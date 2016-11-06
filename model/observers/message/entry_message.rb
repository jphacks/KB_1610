
class EntryMessage
  def update(changed_callback)
    event = changed_callback.event

    if Message.is_postback?(event)
      hash = Message.convert_hash(event)
      if hash['action'] == 'entry'
        Message.reply(event, output)
      end
    end
  end

  def output
    welcome_output = WelcomeMessage.new
    [
        {
            :type => "text",
            :text => "入店が完了しました",
        },
        welcome_output.output
    ]
  end
end