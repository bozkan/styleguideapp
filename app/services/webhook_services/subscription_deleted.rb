module WebhookServices

  class SubscriptionDeleted

    def initialize(params)
      @event                = params[:event]
      @stripe_subscription  = @event.data.object
      @local_subscription   = Subscription.find_by_subscription_merchant_id(@stripe_subscription.id)
    end

    def call
      if @local_subscription
        @local_subscription.user.info.update_attributes!(commission_group_id:nil)
        @local_subscription.update_attributes!(status: @stripe_subscription.status, expiration:Date.today, subscription_merchant_id:nil)
      else
        Rails.logger.warn "[WebhookService::SubscriptionDeleted] No subscription found"
      end
      WebhookServices::ProcessEvent.new({event:@event}).call
      true
    end

  end

end
