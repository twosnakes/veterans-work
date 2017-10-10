class ConversationsController < ApplicationController

  def create
    @quote = Quote.find(params[:quote_id])
    conversation = Conversation.create(quote_id: @quote.id, company_id: @quote.company.id, customer_id: @quote.customer_request.customer.id)
    redirect_to "/conversations/#{conversation.id}"
  end

  def show
    # @message = Message.new
    @messages = Conversation.find(params[:id]).messages.includes(:company, :customer).order('created_at')
    @conversation = Conversation.find(params[:id])
    if @messages.count == 0
      render 'show.html.erb'
    elsif @messages[0].conversation.company == current_company || @messages[0].conversation.customer == current_customer
      render 'show.html.erb'
    else
      redirect_to '/'
    end
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


end
