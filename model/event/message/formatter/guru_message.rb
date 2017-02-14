class GuluMessage
  def output_message(context)
    # encoding: utf-8
    require 'faraday'
    require 'json'
    require 'rest-client'
    gl_app_id = ENV['GULU_API_KEY']
    go_app_id = ENV['GOO_API_KEY']

    #地域に関するワードの取り出し
    request_data = {'app_id'=>go_app_id, "sentence"=>context.value['message']['text']}.to_json
    header = {'Content-type'=>'application/json'}
    https = Net::HTTP.new('labs.goo.ne.jp', 443)
    https.use_ssl=true
    responce = https.post('/api/entity', request_data, header)
    result = JSON.parse(responce.body)

    key = nil
    result['ne_list'].each do |val, cate|
      key = val if cate == 'LOC'
    end

    #県の地域コード取得
    conn = Faraday::Connection.new(url: 'http://api.gnavi.co.jp/master/PrefSearchAPI/20150630/') do |builder|
      builder.use Faraday::Request::UrlEncoded
      builder.use Faraday::Response::Logger
      builder.use Faraday::Adapter::NetHttp
    end
      response = conn.get do |req|
        req.params[:keyid] = gl_app_id
        req.params[:format] = 'json'
        req.headers['Content-Type'] = 'application/json; charset=UTF-8'
      end
      json = JSON.parse(response.body)

      pref = nil
      json["pref"].each do |ap|
        pref = ap["pref_code"] if ap.select {|k, v| v.include?(key)} != {}
      end
    #市町村規模での検索
    conn = Faraday::Connection.new(url: 'http://api.gnavi.co.jp/master/GAreaLargeSearchAPI/20150630/') do |builder|
      builder.use Faraday::Request::UrlEncoded
      builder.use Faraday::Response::Logger
      builder.use Faraday::Adapter::NetHttp
    end

      response = conn.get do |req|
        req.params[:keyid] = gl_app_id
        req.params[:format] = 'json'
        req.headers['Content-Type'] = 'application/json; charset=UTF-8'
      end
      json = JSON.parse(response.body)


      areacode_l = nil
      json["garea_large"].each do |ap|
        areacode_l = ap["areacode_l"] if ap["areaname_l"].include?(key)
        #areacode_l = ap["areacode_l"] if ap.select {|k, v,| k.include?(key)} != {}
      end

      p pref

      p areacode_l



    #レストラン情報取得
    conn = Faraday::Connection.new(url: 'http://api.gnavi.co.jp/RestSearchAPI/20150630/') do |builder|
      builder.use Faraday::Request::UrlEncoded
      builder.use Faraday::Response::Logger
      builder.use Faraday::Adapter::NetHttp
    end
      response = conn.get do |req|
        req.params[:keyid] = gl_app_id
        req.params[:format] = 'json'
        req.params[:pref] = pref if pref != nil
        req.params[:areacode_l] = areacode_l if areacode_l != nil
        req.params[:hit_per_page] = 4
        req.headers['Content-Type'] = 'application/json; charset=UTF-8'
      end

      json = JSON.parse(response.body)

      shop_url1 = json["rest"][0]["url"]
      shop_url2 = json["rest"][1]["url"]
      shop_url3 = json["rest"][2]["url"]
      shop_url4 = json["rest"][3]["url"]
      p "aaaaaaaaaaaaaa"
      
      image_url1 = json["rest"][0]["image_url"]["shop_image1"].sub!(/http:/, "https:") if 
      image_url2 = json["rest"][1]["image_url"]["shop_image1"].sub!(/http:/, "https:")
      image_url3 = json["rest"][2]["image_url"]["shop_image1"].sub!(/http:/, "https:")
      image_url4 = json["rest"][3]["image_url"]["shop_image1"].sub!(/http:/, "https:")

      shop = Shop.where(:name => "YU-YU").first
      j_hash0 = json["rest"][0]["pr"]["pr_short"].scan(/.{1,50}/)
      j_hash1 = json["rest"][1]["pr"]["pr_short"].scan(/.{1,50}/)
      j_hash2 = json["rest"][2]["pr"]["pr_short"].scan(/.{1,50}/)
      j_hash3 = json["rest"][3]["pr"]["pr_short"].scan(/.{1,50}/)

      {
        "type": "template",
        "altText": "this is a carousel template",
        "template": {
            "type": "carousel",
            "columns": [
                {
                    "thumbnailImageUrl": image_url1,
                    "title": json["rest"][0]["name"],
                    "text": j_hash0[0].to_s,
                    "actions": [
                        {
                            "type": "postback",
                            "label": "入店",
                            "data": "action=welcome&shop_id=1"
                        },
                        {
                            "type": "postback",
                            "label": "メニューを見る",
                            "data": "action=show_menu_category&shop_id=1"
                        },
                        {
                            "type": "uri",
                            "label": "サイトを見る",
                            "uri": shop_url1
                        }
                    ]
                },
                {
                    "thumbnailImageUrl": image_url2,
                    "title": json["rest"][1]["name"],
                    "text": j_hash1[0].to_s,
                    "actions": [
                        {
                            "type": "postback",
                            "label": "入店",
                            "data": "action=welcome&shop_id=1"
                        },
                        {
                            "type": "postback",
                            "label": "メニューを見る",
                            "data": "action=show_menu_category&shop_id=1"
                        },
                        {
                            "type": "uri",
                            "label": "サイトを見る",
                            "uri": shop_url2
                        }
                    ]
                },
                {
                    "thumbnailImageUrl": image_url3,
                    "title": json["rest"][2]["name"],
                    "text": j_hash2[0].to_s,
                    "actions": [
                        {
                            "type": "postback",
                            "label": "入店",
                            "data": "action=welcome&shop_id=1"
                        },
                        {
                            "type": "postback",
                            "label": "メニューを見る",
                            "data": "action=show_menu_category&shop_id=1"
                        },
                        {
                            "type": "uri",
                            "label": "サイトを見る",
                            "uri": shop_url3
                        }
                    ]
                },
                {
                    "thumbnailImageUrl": image_url4,
                    "title": json["rest"][3]["name"],
                    "text": j_hash3[0].to_s,
                    "actions": [
                        {
                            "type": "postback",
                            "label": "入店",
                            "data": "action=welcome&shop_id=1"
                        },
                        {
                            "type": "postback",
                            "label": "メニューを見る",
                            "data": "action=show_menu_category&shop_id=1"
                        },
                        {
                            "type": "uri",
                            "label": "サイトを見る",
                            "uri": shop_url4
                        }
                    ]
                },
                {
                    "thumbnailImageUrl": "https://pic.prepics-cdn.com/8d1e39b3e24d1/60207519.jpeg",
                    "title": shop.name.to_s,
                    "text": "安くて美味い！",
                    "actions": [
                        {
                            "type": "postback",
                            "label": "入店",
                            "data": "action=welcome&shop_id=1"
                        },
                        {
                            "type": "postback",
                            "label": "メニューを見る",
                            "data": "action=show_menu_category&shop_id=1"
                        },
                        {
                            "type": "uri",
                            "label": "サイトを見る",
                            "uri": "http://example.com/page/222"
                        }
                    ]
                }
            ]
        }
    }
    end
  end