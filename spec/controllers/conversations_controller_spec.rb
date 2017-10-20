require 'rails_helper'

RSpec.describe ConversationsController, type: :controller do

  describe '#create' do
    context 'no one is signed in' do
      it 'should not create a conversation' do
        quote = create :quote
        expect{
          post :create, params: {quote_id: quote.id}
        }.to change(Conversation, :count).by 0
      end
    end
    context 'customer is signed in' do
      it 'should create a conversation' do
        customer = create :customer
        company = create :company
        customer_request = create :customer_request, customer_id: customer.id
        quote = create :quote, customer_request_id: customer_request.id, company_id: company.id
        sign_in customer
        expect{
          post :create, params: {quote_id: quote.id}
        }.to change(Conversation, :count).by 1
      end
    end
  end
end
