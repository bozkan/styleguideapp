module StripeServices

  class RetrieveCustomerByEmail

    def initialize(params)
      @email          = params[:email]
      @stripe_account = params[:stripe_account]
    end

    def call
      customer = Stripe::Customer.list({email:@email},{stripe_account:@stripe_account})
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
