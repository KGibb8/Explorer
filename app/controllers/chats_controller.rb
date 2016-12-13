class ChatsController < ApplicationController
  include ExpeditionHelper

  before_action :authorise_chat
  before_action :find_chat, only: [:show]

  def index
    @chats = @expedition.chats
  end

  def create
    chat = Chat.create(expedition: @expedition, creator: current_user)
    redirect_to expedition_chats_path(@expedition)
  end

  private

  def authorise_chat
    @expedition = Expedition.find(params[:expedition_id])
    unless current_user && involved
      redirect_to expedition_path(@expedition)
    end
  end

  def find_chat
    @chat = Chat.find(params[:id])
  end

end
