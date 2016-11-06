class ShowMenuMessage
  def update(changed_callback)
    event = changed_callback.event
    category_jp = ''
    @exist_group_id = OrderGroup.where(:line_group_id => event['source']["groupId"]).last

    if Message.is_postback?(event)
      hash = Message.convert_hash(event)
      if hash['action'] == 'show_menu'
        Message.reply(event, output(make_colums(choose_category(hash['category']))))
      end
    elsif Message.is_message?(event)
      for cate in Array['丼', '麺類', 'デザート'] do
        if event.message['text'].include?(cate)
          Message.reply(event, output(make_colums(cate)))
          break
        end
      end
    end
  end

  def output(culums)
    {
        "type": "template",
        "altText": "this is a menu message",
        "template": {
            "type": "carousel",
            "columns": culums
        }
    }
  end

  def choose_category(category)
    case category
      when 'DON' then
        '丼'
      when 'MEN' then
        '麺類'
      when 'DES' then
        'デザート'
    end
  end

  def make_colums(category)
    colums = []
    for m in Menu.where(:category => category)
      actions = make_actions(m.id.to_s)
      colums.append(
          {
              "thumbnailImageUrl": m.picture,
              "title": m.name,
              "text": m.price.to_s + "円",
              "actions": actions
          }
      )
    end
    colums
  end

  def make_actions(id)
    actions = []
    if @exist_group_id
      if @exist_group_id['enter']
        # actions.push(
        #     {
        #         "type": "postback",
        #         "label": "注文",
        #         "data": "action=order&itemid=" + id
        #     }
        # )
        actions.push(
         {
             "type": "message",
             "label": "注文",
            "text": "注文"
         }
    )
      end
    end
    #  actions.push(
    #      {
    #          "type": "postback",
    #          "label": "一旦置いとく",
    #         "data": "action=add_tray&itemid=" + id
    #      }
    # )
     actions.push(
         {
             "type": "message",
             "label": "一旦置いとく",
            "text": "一旦置いとく"
         }
    )
    
    p actions
    actions
  end
end
