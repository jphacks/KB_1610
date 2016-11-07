class WaterMessage
  def update(changed_callback)
    event = changed_callback.event

      hash = Message.convert_hash(event)
        Message.reply(event, output)
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