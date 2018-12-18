module StripeServices

  class ChangePlan

    def initialize(params)
      @stripe_account   = params[:stripe_account]
      @subscription_id = params[:subscription_id] # sub_CBb6IXqvTLXp3f
      @plan_id         = params[:plan_id] # plan_CBb6IXqvTLXp3f
    end

    def call
      subscription = Stripe::Subscription.retrieve(@subscription_id,{stripe_account:@stripe_account})
      subscription.cancel_at_period_end = false
      subscription.items = [{
          id: subscription.items.data[0].id,
          plan: @plan_id,
      }]
      subscription.save
    rescue Stripe::StripeError => e
      OpenStruct.new({success?: false, error: e})
    else
      OpenStruct.new({success?: true, payload: subscription})
    end

  end

end
