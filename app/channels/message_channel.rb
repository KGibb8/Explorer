# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class MessageChannel < ApplicationCable::Channel
  def subscribed
    stream_from "messages_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def create(message)
    # message = Message.create(data["message"])
    binding.pry
    ActionCable.server.broadcast("messages_channel", { message: message } ) #{message: message, user: message.user}
  end
end
