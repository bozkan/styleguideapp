module WebhookServices

  class PaymentSucceeded

    def initialize(params)
      @event                 = params[:event]
      @invoice               = @event.data.object
      @subscription        ||= Subscription.find_by_stripe_id(@invoice.subscription)
      @account               = @subscription.account
      @stripe_subscription ||= StripeServices::RetrieveSubscription.new({subscription_id:@invoice.subscription}).call
    end

    def call
      if @subscription
        @invoice.attempt_count > 1 ? update_failed_payment : create_payment
        update_subscription
      else
        Rails.logger.warn "[WebhookService::PaymentSucceeded] No subscription found"
      end
      WebhookServices::ProcessEvent.new({event:@event}).call
      true
    end

    private

      attr_reader :event, :invoice, :subscription, :stripe_subscription, :account

      def update_failed_payment
        last_failed_payment.update_attributes(payment_params)
      end

      def last_failed_payment
        payments ||= subscription.payments.where(paid: false)
        payments.last if payments.exists?
      end

      def create_payment
        payment = subscription.payments.create!(payment_params)
      end

      def update_subscription
        subscription.update_attributes!(
          status: 'active',
          expiration:subscription_expiration
        )
      end

      def subscription_expiration
        Time.at(stripe_subscription.payload.current_period_end).to_datetime
      end

      def payment_params
        {
          paid:true,
          amount_cents: (invoice.amount_paid || 0),
          transaction_id: invoice.charge,
          account: account
        }
      end

  end

end
