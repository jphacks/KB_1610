
class WelcomeMessage

  def initialize
    @hash
    @event
  end

  def update(changed_callback)
    event = changed_callback.event
    @event = changed_callback.event
    if Message.is_postback?(event)
      @hash = Message.convert_hash(event)
      if @hash['action'] == 'welcome'
        if @hash.has_key?("shop_id")
          order_group_create(event)
          Message.reply(event, output)
        else
          Message.reply(event, output_miss)
        end
      end
    elsif Message.is_message?(event)
      if event.message['text'].include?("ようこそ")
        Message.reply(event, output)
      end
    end
  end

  def order_group_create(event)
    order = OrderGroup.find_or_create_by(
        :line_group_id => event['source']['groupId'],
        :shop_id => @hash['shop_id'],
        :enter => true
    )
  end

  def output
    {
        'type': "template",
        "altText": 'this is a welcome message',
        "template": {
            "type": 'buttons',
            "text": '御来店ありがとうございます．当店は，LINEによる注文を承っています．以下から，メニュー，ヘルプ，初めての方へのいずれかをお選びください',
            "actions": [
                {
                    "type": "postback",
                    "label": "メニュー",
                    "data": "action=show_menu_category&shop_id=" + @hash['shop_id']
                },
                {
                    "type": "postback",
                    "label": "本日のおすすめ",
                    "data": "action=buy&itemid=123"
                },
                {
                    "type": "postback",
                    "label": "ヘルプ",
                    "data": "action=help"
                },
                {
                    "type": "postback",
                    "label": "はじめての方へ",
                    "data": "action=first_time"
                }
            ]
        }
    }
  end

  def output_miss
    {
        :type => 'text',
        :text => '入店に失敗しました'
    }
  end
end