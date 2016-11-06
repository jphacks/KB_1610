class ShowMenuMessage
  def update(changed_callback)
    event = changed_callback.event
    category_jp = ''
    @exist_group_id = OrderGroup.where(:line_group_id => event['source']["groupId"]).last

    if Message.is_postback?(event)
      hash = Message.convert_hash(event)
      if hash['action'] == 'show_menu'
        if hash["category"] == "STK"
          Message.reply(event, output(make_colums(hash["category"],event)))
        else
          Message.reply(event, output(make_colums(choose_category(hash['category']),event)))
        end
      end
    elsif Message.is_message?(event)
      for cate in Array['丼', '麺類', 'デザート'] do
        if event.message['text'].include?(cate)
          Message.reply(event, output(make_colums(cate, event)))
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

  def make_colums(category, event)
    colums = []
    if category == "STK"
      group = OrderGroup.where(:line_group_id => event['source']["groupId"]).last
      for m in Order.where(["ordered = ? and order_group_id = ?", false, group.id])
        actions = make_actions(m.menu.id.to_s, event)
        colums.append(
        {
          "thumbnailImageUrl": m.menu.picture,
          "title": m.menu.name,
          "text": m.menu.price.to_s + "円",
          "actions": actions
        }
        )
      end
    else
      for m in Menu.where(:category => category)
        actions = make_actions(m.id.to_s, event)
        colums.append(
        {
          "thumbnailImageUrl": m.picture,
          "title": m.name,
          "text": m.price.to_s + "円",
          "actions": actions
        }
        )
      end
    end
    colums
  end

  def make_actions(id, event)
    actions = []
    if @exist_group_id
      if @exist_group_id.enter == true
        gid = @exist_group_id["id"]
        actions.push(
            {
                "type": "postback",
                "label": "注文",
                "data": "action=order&itemid=#{id}&gid=#{gid}"
            }
        )
      end
    end
    group = OrderGroup.find_or_create_by(:line_group_id => event['source']["groupId"]) do |group|
      group.enter = false,
      group.shop_id = 1
    end
    actions.push(
        {
            "type": "postback",
            "label": "一旦置いとく",
            "data": "action=add_tray&itemid=#{id}&gid=#{group.id}"
        }
    )
    p actions
    actions
  end
end
