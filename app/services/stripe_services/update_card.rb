module StripeServices

  class UpdateCard

    def initialize(params)
      @customer_id    = params[:customer_id]
      @token          = params[:token]
    end

    def call
      customer = Stripe::Customer.retrieve(@customer_id)
      customer.source = @token
      customer.save
    rescue Stripe::StripeError => e
      OpenStruct.new({success?: false, error: e})
    else
      OpenStruct.new({success?: true, payload: customer})
    end

  end

end
