
class CheckMessageSplit
  def update(changed_callback)
    event = changed_callback.event

    if Message.is_postback?(event)
      hash = Message.convert_hash(event)
      if hash['action'] == 'check_split'
        Message.reply(event, output)
      end
    elsif Message.is_message?(event)
      if /(割り勘|ワリカン|わりかん)/ =~ event.message['text']
        Message.reply(event, output)
      end
    end
  end

  def output
    [
        {
            :type => 'text',
            :text => "合計金額9000円になります．一人あたり3000円になります．退店の際，以下の画面を店員に表示してください．ご利用ありがとうございました．",
        },
        {
            :type => 'image',
            :originalContentUrl => 'https://icondecotter.jp/data/8047/241416112/bf1b4445f67a119b486936740e45c964.png',
            :previewImageUrl => 'https://icondecotter.jp/data/8047/241416112/bf1b4445f67a119b486936740e45c964.png'
        }
    ]
  end
end