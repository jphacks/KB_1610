class MokMessage
  def output_message(context)
    context.value['message']['text'] = context.value['message']['text'] + "リストに保存しました"
    {
      type: "text",
      text: context.value['message']['text']
    }
  end
end