class ChatController < WebsocketRails::BaseController
  def new_message
    # messageという変数が送られてくる
    broadcast_message :new_message, message
  end
end
