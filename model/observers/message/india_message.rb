class IndiaMessage
  def update(changed_callback)
    event = changed_callback.event
    if Message.is_postback?(event)
    elsif Message.is_message?(event)
      if /(テストです)/ =~ event.message['text']
        require "geocoder"
        @test = Test.create(:name => "タージマハル", :address => "Chandni Chowk, New Delhi, Delhi, India  ")
        Message.reply(event, output(@test))
      end
    end
  end

  def output(test)
    [
        {
           type: "text",
           text: "a"
        },
        {
        type: "sticker",
        packageId: 1,
        stickerId: 1
        },
        {
        "type": "location",
        "title": test.name,
        "address": test.address,
        "latitude": test.latitude,
        "longitude": test.longitude
    }
    ]
  end
end