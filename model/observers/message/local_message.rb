class LocalMessage
  def update(changed_callback)
    event = changed_callback.event
    if Message.is_postback?(event)
    elsif Message.is_message?(event)
      if /(雑談)/ =~ event.message['text']
        text = get_user_local_bot_reply(event.message["text"].delete("雑談"))
        Message.reply(event, output(text))
      end
    end
  end

  def output(text)
    [
      {
        type: "text",
        text: text
      },
      {
        type: "text",
        text: text
      },
    ]
  end

  def get_user_local_bot_reply(word)
    require 'rest-client'
    response = RestClient.get 'https://chatbot-api.userlocal.jp/api/chat', { params: { key: ENV['USR_LOCAL_API_KEY'], message: CGI.escape(word)} }
    response_json = JSON.parse(response)
    p response_json['result']
    response_json['status'] == "success" ? response_json['result'] : '通信エラー'
  end
end