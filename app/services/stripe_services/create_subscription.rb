module StripeServices

  class CreateSubscription

    def initialize(params)
      @subscription_params  = params[:subscription_params]
      @stripe_account       = params[:stripe_account]
    end

    def call
      subscription = Stripe::Subscription.create(@subscription_params,{stripe_account:@stripe_account})
    rescue Stripe::StripeError => e
      OpenStruct.new({success?: false, error: e})
    else
      OpenStruct.new({success?: true, payload: subscription})
    end

  end

end
