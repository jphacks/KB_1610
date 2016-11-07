class WaterMessage
  def update(changed_callback)
    event = changed_callback.event
    if Message.is_postback?(event)
    elsif Message.is_message?(event)
      if /(お水|喉|こぼれた|溢れた)/ =~ event.message['text']
        hash = Message.convert_hash(event)
        Message.reply(event, output)
      end
    end
  end

  def output
    [
        {
        type: "sticker",
        packageId: 1,
        stickerId: 1
        },
        {
           type: "text",
           text: "あ、お水ですね！少々お待ちください☺️"
        },
        {
        type: "sticker",
        packageId: 1,
        stickerId: 1
        }
    ]
  end
end