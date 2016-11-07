class NickNameMessage
  def update(changed_callback)
    event = changed_callback.event
    if Message.is_postback?(event)
    elsif Message.is_message?(event)
      if /(ニックネーム)/ =~ event.message['text']
        event.message["text"] = event.message["text"].delete("ニックネーム")
        text = get_user_local_bot_reply(event.message["text"])
        Message.reply(event, output(text))
      end
    end
  end

  def output(text)
    [
      {
        type: "text",
        text: "じゃあ、あなたのあだ名は#{text}ね！"
        }
      ]
    end

    def get_user_local_bot_reply(word)
      response = RestClient.get 'https://chatbot-api.userlocal.jp/api/name', { params: { key: ENV['USR_LOCAL_API_KEY'], name: CGI.escape(word)} }
      response_json = JSON.parse(response)
      response_json["result"]["nickname"][rand(10)]
  end
end