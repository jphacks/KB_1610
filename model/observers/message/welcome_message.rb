
class WelcomeMessage
  def update(changed_callback)
    p "WELCOME"
    event = changed_callback.event
    p event
    if Message.is_postback?(event)
      hash = Message.convert_hash(event)
      if hash['action'] == 'welcome'
        p hash
        if hash.has_key?("shop_id")
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
                    "data": "action=show_menu_category"
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