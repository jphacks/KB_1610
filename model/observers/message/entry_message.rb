
class EntryMessage

  def update(changed_callback)
    if Message.is_postback?(changed_callback.event)
      hash = Message.convert_hash(changed_callback.event)
      if hash['action'] == 'entry'
        Message.reply(changed_callback.event, output(changed_callback))
      end
    end
  end

  def output(callback)
    welcome_output = WelcomeMessage.new
    [
        {
            :type => "text",
            :text => "Yu-Yuの入店が完了しました",
        },
        welcome_output.update(callback)
    ]
  end
end