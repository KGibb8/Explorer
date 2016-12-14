# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class MessageChannel < ApplicationCable::Channel

  def subscribed
    stream_from "messages_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def create(data)
    message = current_user.messages.create(chat_id: data["message"]["chat_id"], body: data["message"]["body"])
    ActionCable.server.broadcast("messages_channel", action: 'create', message: render_message(message), chat_id: data["message"]["chat_id"] )
  end

  def update(data)
    chat = Chat.find(data["message"]["chat_id"])
    message = chat.messages.find(data["message"]["id"])
    message.update(body: data["message"]["body"])
    ActionCable.server.broadcast("messages_channel", action: "update", message: message, chat_id: data["message"]["chat_id"], id: message.id)
  end

  def destroy(data)
    chat = Chat.find(data["message"]["chat_id"])
    message = chat.messages.find(data["message"]["id"])
    message_id = message.id
    message.destroy
    ActionCable.server.broadcast("messages_channel", action: "destroy", message_id: message_id, chat_id: data["message"]["chat_id"])
  end

  def render_message(message)
    renderer = ApplicationController.renderer.new
    renderer.instance_variable_set(:@env, {"HTTP_HOST"=>"localhost:3000",
      "HTTPS"=>"off",
      "REQUEST_METHOD"=>"GET",
      "SCRIPT_NAME"=>"",
      "warden" => warden })
    renderer.render(partial: 'messages/message', locals: { message: message } )
  end

end
