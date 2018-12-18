module StripeServices

  class CreateCharge

    def initialize(params)
      @payment_params   = params[:payment_params]
      @stripe_account   = params[:stripe_account]
    end

    def call
      charge = Stripe::Charge.create(@payment_params,{stripe_account:@stripe_account})
    rescue Stripe::InvalidRequestError => e
      OpenStruct.new({success?: false, error: e})
    else
      OpenStruct.new({success?: true, payload: charge})
    end

  end

end
