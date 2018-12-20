module WebhookServices

  class PaymentFailed

    def initialize(params)
      @event        = params[:event]
      @invoice      = @event.data.object
      @subscription ||= Subscription.find_by_stripe_id(@invoice.subscription)
      @account      = @subscription.account
    end

    def call
      if @subscription
        @invoice.attempt_count > 1 ? update_failed_payment : create_failed_payment
        update_subscription
      else
        Rails.logger.warn "[WebhookService::PaymentFailed] No subscription found"
      end
      WebhookServices::ProcessEvent.new({event:@event}).call
      true
    end

    private

      attr_reader :event, :invoice, :subscription, :account

      def update_failed_payment
        last_failed_payment.update_attributes(attempts:invoice.attempt_count)
      end

      def last_failed_payment
        payments ||= subscription.payments.where(paid: false)
        payments.last if payments.exists?
      end

      def create_failed_payment
        payment = subscription.payments.create!(
          paid: false,
          amount_cents:0,
          account: account
        )
      end

      def update_subscription
        subscription.update_attributes!(status: 'past_due')
      end

  end

end
