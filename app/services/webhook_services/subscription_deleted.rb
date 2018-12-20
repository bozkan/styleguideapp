module WebhookServices

  class SubscriptionDeleted

    def initialize(params)
      @event                = params[:event]
      @stripe_subscription  = @event.data.object
      @local_subscription   = Subscription.find_by_stripe_id(@stripe_subscription.id)
    end

    def call
      if @local_subscription
        @local_subscription.update_attributes!(status: @stripe_subscription.status, expiration:Date.today, stripe_id:nil)
      else
        Rails.logger.warn "[WebhookService::SubscriptionDeleted] No subscription found"
      end
      WebhookServices::ProcessEvent.new({event:@event}).call
      true
    end

  end

end
