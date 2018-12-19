module StripeServices

  class CreateSubscription

    def initialize(params)
      @subscription_params  = params[:subscription_params]
    end

    def call
      subscription = Stripe::Subscription.create(@subscription_params)
    rescue Stripe::StripeError => e
      OpenStruct.new({success?: false, error: e})
    else
      OpenStruct.new({success?: true, payload: subscription})
    end

  end

end
