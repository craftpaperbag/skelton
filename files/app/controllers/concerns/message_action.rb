# コントローラーで、
# 次の画面で表示したいビューを貯めるメソッドmessage
#
# In controllers
#     message 'shared/hogehoge'
# 
# 準備 app/views/shared/hogehoge.html.slim
#
# よびだし render 'shared/messages'
#
module MessageAction
  def message(message)
    @messages ? @messages << message : @messages = [message]
  end
  attr_reader :messages
end
