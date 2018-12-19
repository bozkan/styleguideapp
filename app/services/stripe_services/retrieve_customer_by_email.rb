module StripeServices

  class RetrieveCustomerByEmail

    def initialize(params)
      @email          = params[:email]
    end

    def call
      customer = Stripe::Customer.list({email:@email})
      result  = customer.data.present? ? customer.data.first.id : nil
    rescue Stripe::StripeError => e
      OpenStruct.new({success?: false, error: e})
    else
      if result.nil?
        OpenStruct.new({success?: false})
      else
        OpenStruct.new({success?: true, payload:result})
      end
    end

  end

end
