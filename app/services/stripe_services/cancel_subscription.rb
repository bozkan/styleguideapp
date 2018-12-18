module StripeServices

  class CancelSubscription

    def initialize(params)
      @subscription_id = params[:subscription_id]
      @stripe_account  = params[:stripe_account]
    end

    def call
      subscription = Stripe::Subscription.retrieve(@subscription_id,{stripe_account:@stripe_account})
      subscription.cancel_at_period_end = true
      subscription.save
    rescue Stripe::StripeError => e
      OpenStruct.new({success?: false, error: e})
    else
      OpenStruct.new({success?: true, payload: subscription})
    end

  end

end
