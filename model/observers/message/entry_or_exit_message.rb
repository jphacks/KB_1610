
class EntryOrExitMessage
  def update(changed_callback)
    event = changed_callback.event

    if Message.is_postback?(event)
      hash = Message.convert_hash(event)
      if hash['action'] == 'entry_or_exit'
        Message.reply(event, output)
      end
    elsif Message.is_message?(event)
      if /(入店|退店|入退店)/ =~ event.message['text']
        Message.reply(event, output)
      end
    end
  end

  def output
    {
        "type": "template",
        "altText": "this is a Entry or Exit message",
        "template": {
            "type": "buttons",
            "title": "入退店の設定",
            "text": "入退店の設定を行います",
            "actions": [
                {
                    "type": "postback",
                    "label": "入店",
                    "data": "action=welcome&shop_id=1"
                },
                {
                    "type": "postback",
                    "label": "退店",
                    "data": "action=exit"
                },
        {
            "type": "postback",
        "label": "入店失敗",
        "data": "action=welcome"
    }
            ]
        }
    }
  end
end