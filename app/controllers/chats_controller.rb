class ChatsController < ApplicationController
  include ExpeditionHelper

  before_action :authorise_chat

  def index
    @chats = @expedition.chats
    @message = Message.new
    @chat = Chat.new
  end

  def create
    my_chat_params = chat_params.to_h
    my_chat_params["messages_attributes"]["0"]["user_id"] = current_user.id
    chat = Chat.create(my_chat_params.to_h.merge(expedition: @expedition, creator: current_user))
    redirect_to expedition_chats_path(@expedition)
  end

  private

  def chat_params
    params.require(:chat).permit(:topic, messages_attributes: [:body])
  end

  def authorise_chat
    @expedition = Expedition.find(params[:expedition_id])
    unless current_user && involved
      redirect_to expedition_path(@expedition)
    end
  end

end
