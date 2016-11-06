
class OrderCompleteMessage
  def initialize(serif)
        @serif = serif
  end
  def output_message(context)
    {
       "type":  "text",
       "text": @serif
    }
  end
end