class WaterMessage
  def update(changed_callback)
    event = changed_callback.event
    if Message.is_postback?(event)
      hash = Message.convert_hash(event)
      if hash['action'] == 'check'
        group = OrderGroup.where(:line_group_id => event['source']["groupId"]).last
        money = 0
        group.orders.each do |order|
          money += order.menu.price if order.ordered == true
        end
        Message.reply(event, output(money))
      end
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