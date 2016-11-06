class ExitMessage
  def update(changed_callback)
    event = changed_callback.event

    if Message.is_postback?(event)
      hash = Message.convert_hash(event)
      if hash['action'] == 'exit'
        Message.reply(event, output)
      end
    end
  end

  def output
    {
        :type => "text",
        :text => "退店しました．またのお越しをお待ちしております．",
    }
  end
end