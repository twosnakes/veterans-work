class ConversationsController < ApplicationController

  def create
    conversations = Conversation.create(conversations_params)
    redirect_to "/conversations/#{conversations.id}"
  end

  def show
    @messages = Conversation.find(params[:id]).messages.includes(:company, :customer).order('created_at')
  end



  private

  def conversations_params
    params.permit(:company_id, :customer_id)
  end

end
