class ConversationsController < ApplicationController

  def create
    conversations = Conversation.create(conversations_params)
    redirect_to "/conversations/#{conversations.id}"
  end

  def show
    @message = Message.new
    @messages = Conversation.find(params[:id]).messages.includes(:company, :customer).order('created_at')
  end

  def message
    @conversation = Conversation.find(params[:id])
    if params[:customer_id]
      @message = Message.create(body: params[:body], conversation_id: @conversation.id, customer_id: params[:customer_id])
      redirect_to "/conversations/#{@conversation.id}"
    elsif params[:company_id]
      @message = Message.create(body: params[:body], conversation_id: @conversation.id, company_id: params[:company_id])
      redirect_to "/conversations/#{@conversation.id}"
    else
      flash[:notice] = "You need to be signed in to create a message."
      redirect_to '/'
    end
  end


  private

  def conversations_params
    params.permit(:company_id, :customer_id)
  end

end
