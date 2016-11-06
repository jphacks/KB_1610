
class ShowMenuCategoryMessage
  def update(changed_callback)
    event = changed_callback.event

    if Message.is_postback?(event)
      hash = Message.convert_hash(event)
      if hash['action'] == 'show_menu_category'
        Message.reply(event, output)
      end
    elsif Message.is_message?(event)
      if event.message['text'].include?("カテゴリー")
        Message.reply(event, output)
      end
    end
  end

  def output
    {
        "type": "template",
        "altText": "this is a category message",
        "template": {
            "type": "buttons",
            "text": "カテゴリーを選んだください",
            "actions": [
                {
                    "type": "postback",
                    "label": "丼",
                    "data": "action=show_menu&category=DON"
                },
                {
                    "type": "postback",
                    "label": "麺類",
                    "data": "action=show_menu&category=MEN"
                },
                {
                    "type": "postback",
                    "label": "デザート",
                    "data": "action=show_menu&category=DES"
                },
                {
                    "type": "postback",
                    "label": "置いとくリスト",
                    "data": "action=show_menu&category=DON"
                }
            ]
        }
    }
  end
end