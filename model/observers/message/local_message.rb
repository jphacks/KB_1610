class LocalMessage
  def update(changed_callback)
    event = changed_callback.event
    if Message.is_postback?(event)
    elsif Message.is_message?(event)
      if /(雑談)/ =~ event.message['text']
        event.message["text"] = event.message["text"].delete("雑談")
        text = []
        for i in 1..2 do
          text[i] = get_user_local_bot_reply(event.message["text"])
        end
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
    require 'rest-client'
    response = RestClient.get 'https://chatbot-api.userlocal.jp/api/chat', { params: { key: ENV['USR_LOCAL_API_KEY'], message: CGI.escape(word)} }
    response_json = JSON.parse(response)
    cat_res =RestClient.get 'https://chatbot-api.userlocal.jp/api/character', { params: { key: ENV['USR_LOCAL_API_KEY'], message: response_json['result'], character_type: "cat"} }
    dog_res =RestClient.get 'https://chatbot-api.userlocal.jp/api/character', { params: { key: ENV['USR_LOCAL_API_KEY'], message: response_json['result'], character_type: "dog"} }
    roujin_res =RestClient.get 'https://chatbot-api.userlocal.jp/api/character', { params: { key: ENV['USR_LOCAL_API_KEY'], message: response_json['result'], character_type: "roujin"} }
    cat_res_json = JSON.parse(cat_res)
    dog_res_json = JSON.parse(dog_res)
    roujin_res_json = JSON.parse(roujin_res)
    p response_json['result']
    p cat_res_json["result"]
    p dog_res_json["result"]
    p roujin_res_json["result"]
    response_json['status'] == "success" ? response_json['result'] : '通信エラー'
  end
end