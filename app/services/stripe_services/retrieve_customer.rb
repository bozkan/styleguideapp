module StripeServices

  class RetrieveCustomer

    def initialize(params)
      @customer_id      = params[:customer_id]
    end

    def call
      customer = Stripe::Customer.retrieve(@customer_id)
    rescue Stripe::StripeError => e
      OpenStruct.new({success?: false, error: e})
    else
      OpenStruct.new({success?: true, payload: customer})
    end

  end

end
