module StripeServices

  class CreateCustomer

    def initialize(params)
      @customer_params  = params[:customer_params]
    end

    def call
      customer = Stripe::Customer.create(@customer_params)
    rescue Stripe::StripeError => e
      OpenStruct.new({success?: false, error: e})
    else
      OpenStruct.new({success?: true, payload: customer})
    end

  end

end
