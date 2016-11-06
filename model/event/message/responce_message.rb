
class ResponceMessage
  def output_message(context)
    event = context.value
    text = event.message['text']

    if text.include?("画像")
      message = MessageContext.new(ImageMessage.new)
    elsif text.include?("名言")
      message = MessageContext.new(RemarkMessage.new)
    elsif text.include?("住所")
      message = MessageContext.new(LocationMessage.new)
    elsif text.include?("スタンプ")
      message = MessageContext.new(StickerMessage.new)
    elsif text.include?("イメージリンク")
      message = MessageContext.new(ImagemapMessage.new)
    elsif text.include?("ボタン")
      message = MessageContext.new(ButtonMessage.new)
    elsif text.include?("リッチ")
      message = MessageContext.new(RichMessage.new)
    elsif text.include?("確認")
      message = MessageContext.new(ConfirmMessage.new)
    elsif text.include?("ミーティング")
      message = MessageContext.new(MeetingMessage.new)
    elsif text.include?("翻訳")
      message = MessageContext.new(TranslateMessage.new, event)
    elsif text.include?("入店")
      OrderGroup.create(:enter => true,
        :start_time => Time.now,
        :end_time => Time.now + 60*60*2,
        :table => 1,
        :user_id => event['source']["userId"]
        )
      message = MessageContext.new(DefaultMessage.new, event)
    elsif text.include?("退店")
      mygroup = OrderGroup.where(:user_id => event['source']["userId"])
      mygroup.update(:enter => false)
      message = MessageContext.new(DefaultMessage.new, event)
    elsif text.include?("店選び")
      message = MessageContext.new(GooMessage.new, event)
    elsif text.include?("ぐるなび")
      message = MessageContext.new(GuluMessage.new, event)
    elsif text.include?("検索")
      message = MessageContext.new(SearchMessage.new, event)
    elsif text.include?("一旦置いとく")
      message = MessageContext.new(MokMessage.new, event)
    elsif text.include?("注文")
      message = MessageContext.new(MokMessage.new, event)
    else
      message = MessageContext.new(DefaultMessage.new, event)
    end

    message.output_message
  end
end