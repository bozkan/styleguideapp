module StripeServices

  class CreateCharge

    def initialize(params)
      @payment_params   = params[:payment_params]
    end

    def call
      charge = Stripe::Charge.create(@payment_params)
    rescue Stripe::InvalidRequestError => e
      OpenStruct.new({success?: false, error: e})
    else
      OpenStruct.new({success?: true, payload: charge})
    end

  end

end
