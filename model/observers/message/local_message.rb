class LocalMessage
  def update(changed_callback)
    event = changed_callback.event
    if Message.is_postback?(event)
    elsif Message.is_message?(event)
      if /(雑談)/ =~ event.message['text']
        event.message["text"] = event.message["text"].delete("雑談")
        text = get_user_local_bot_reply(event.message["text"])
        Message.reply(event, output(text))
      end
    end
  end

  def output(text)
    [
      {
        type: "text",
        text: text[1].to_s
        },
        {
          type: "text",
          text: text[2].to_s
        }
      ]
    end

    def get_user_local_bot_reply(word)
      if /(犬)/ =~ word
        word = word.delete("犬")
        num = 1
      elsif /(猫)/ =~ word
        word = word.delete("猫")
        num = 2
      elsif /(老人)/ =~ word
        word = word.delete("老人")
        num = 3
      else
        num = 4
      end
      response = RestClient.get 'https://chatbot-api.userlocal.jp/api/chat', { params: { key: ENV['USR_LOCAL_API_KEY'], message: CGI.escape(word)} }
      response_json = JSON.parse(response)
      case num
      when 1
        res = RestClient.get 'https://chatbot-api.userlocal.jp/api/character', { params: { key: ENV['USR_LOCAL_API_KEY'], message: response_json['result'] + "な", character_type: "cat"} }
      when 2
        res = RestClient.get 'https://chatbot-api.userlocal.jp/api/character', { params: { key: ENV['USR_LOCAL_API_KEY'], message: response_json['result'] + "です", character_type: "dog"} }
      when 3
        res = RestClient.get 'https://chatbot-api.userlocal.jp/api/character', { params: { key: ENV['USR_LOCAL_API_KEY'], message: response_json['result'] + "だよ", character_type: "roujin"} }
      when 4
        res = response
      end
        res_json = JSON.parse(res)
  end
end