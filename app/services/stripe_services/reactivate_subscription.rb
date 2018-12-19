module StripeServices

  class ReactivateSubscription

    def initialize(params)
      @subscription_id  = params[:subscription_id]
    end

    def call
      subscription = Stripe::Subscription.retrieve(@subscription_id)
      subscription.cancel_at_period_end = false
      subscription.save
    rescue Stripe::StripeError => e
      OpenStruct.new({success?: false, error: e})
    else
      OpenStruct.new({success?: true, payload: subscription})
    end

  end

end
