# frozen_string_literal: true

require 'rails_helper'

require 'stripe'

RSpec.describe Stripe::Checkout::Session do 
    
    before do 
        Stripe.api_key = Rails.application.credentials[:stripe][:private_key]
    end

    it 'creates a checkout session' do 
        params = {
            mode: 'payment',
            line_items: [{
                price: 'price_1MTSArJ3mr6ZGetwrZCxJjmv', 
                quantity: 1
            }],
            success_url: "http://localhost:3000/?session_id={CHECKOUT_SESSION_ID}",
            cancel_url: "http://localhost:3000/?session_id={CHECKOUT_SESSION_ID}",
        }

        session = Stripe::Checkout::Session.create(params)
        expect(session.id).to be_present
    end
end
