module StripeServices

  class RetrieveSubscription

    def initialize(params)
      @subscription_id  = params[:subscription_id]
      @stripe_account   = params[:stripe_account]
    end

    def call
      subscription = Stripe::Subscription.retrieve(@subscription_id,{stripe_account:@stripe_account})
    rescue Stripe::StripeError => e
      OpenStruct.new({success?: false, error: e})
    else
      OpenStruct.new({success?: true, payload: subscription})
    end

  end

end
