class SearchMessage
  def output_message(context)

    require 'net/https'
    require 'json'
    app_id = ENV['GOO_API_KEY']
    request_data = {'app_id'=>app_id, "sentence"=>context.value['message']['text'].delete("検索"), "info_filter"=>"form|pos"}.to_json
    header = {'Content-type'=>'application/json'}
    https = Net::HTTP.new('labs.goo.ne.jp', 443)
    https.use_ssl=true
    responce = https.post('/api/morph', request_data, header)
    result = JSON.parse(responce.body)
    res = result['word_list'][0]
    key = nil
    res.each do |val, cate|
        if cate == "名詞"
            key = val
        else
        end
    end

    menu = self.search_menu(key)
    #menu2 = Menu.where("name LIKE?", "%#{key}%").first
    {
        "type": "template",
        "altText": "this is a carousel template",
        "template": {
            "type": "carousel",
            "columns": [
                {
                    "thumbnailImageUrl": menu.picture.to_s,
                    "title": menu.name.to_s,
                    "text": menu.price.to_s,
                    "actions": [
                        {
                            "type": "postback",
                            "label": "注文",
                            "data": "action=order&itemid=" + menu.id.to_s
                        },
                    ]
                }
             ]
        }
    }
    end
        def search_menu(key)
    # images = [
    #     'https://pbs.twimg.com/media/B_QHDbSVEAA1adJ.jpg',
    #     'https://pbs.twimg.com/media/BuHSdwCCAAELvUK.jpg',
    #     'https://i.ytimg.com/vi/6nQyHeiDHu0/hqdefault.jpg',
    #     'https://s-media-cache-ak0.pinimg.com/564x/f2/a2/4f/f2a24f58f13823def4053e1ae32f2557.jpg',
    #     'https://pbs.twimg.com/media/CZQMsB-UYAQ-GJA.jpg',
    #     'https://ssl-stat.amebame.com/pub/content/8265872137/user/article/194267610976870743/ea20fa0d12335b8b2735d1a768d0932a/cached.jpg',
    #     'https://s-media-cache-ak0.pinimg.com/236x/f6/5c/8d/f65c8dfee01d6407e9e9cd8298cbeb5d.jpg',
    #     'https://pbs.twimg.com/media/CMTT-vPUAAErxqJ.png',
    #     'https://pbs.twimg.com/media/Bc7INKDCQAAp1d8.jpg',
    #     'https://pbs.twimg.com/media/B5RSK0pCYAA45il.png'
    # ]
    # images.sample
    menu = Menu.where("name LIKE?", "%#{key}%").first
end
end