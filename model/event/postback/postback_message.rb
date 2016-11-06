
class PostbackMessage
  def output_message(context)
    hash = context.value

    if hash.has_key?('category')
      category = hash['category']
      message = MessageContext.new(ShowMenuMessage.new(Menu, category))
      if category == 'befDON'
        message = MessageContext.new(ShowDonMessage.new('丼'))
      elsif category == 'befMEN'
        message = MessageContext.new(ShowDonMessage.new('麺類'))
      elsif category == 'befDES'
        message = MessageContext.new(ShowDonMessage.new('デザート'))
      end
    elsif hash.has_key?('action')
      action = hash['action']
      itemid = hash["itemid"].to_i
      groupid = hash["gid"]
      if action == 'order'
        serif = "を注文しました"
        menu = Menu.find(itemid)
        order = Order.create(
          :menu_id => menu.id,
          :order_group_id => groupid,
          :ordered => true
          )
      elsif action == 'add_tray'
        serif = "をストックに入れました"
        menu = Menu.find(itemid)
        order = Order.create(
          :menu_id => menu.id,
          :order_group_id => groupid,
          :ordered => false
          )
      end
        message = MessageContext.new(OrderCompleteMessage.new(order.menu.name + serif))
    else
      exit 1
    end

    message.output_message
  end
end