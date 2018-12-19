module WebhookServices

  class PaymentSucceeded

    def initialize(params)
      @event                 = params[:event]
      @invoice               = @event.data.object
      @subscription        ||= Subscription.find_by_subscription_merchant_id(@invoice.subscription)
      @user                ||= @subscription.user
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

      attr_reader :event, :invoice, :subscription, :stripe_subscription, :user

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
        set_commission_group_from_plan
      end

      def subscription_expiration
        Time.at(stripe_subscription.payload.current_period_end).to_datetime
      end

      def payment_params
        {
          paid:true,
          amount: (invoice.amount_paid || 0),
          user: subscription.user,
          transaction_id: invoice.charge
        }
      end

      def set_commission_group_from_plan
       user.info.update_attributes(commission_group_id: subscription.plan.commission_group_id) if user_commission_group_updateable?
     end

     def user_commission_group_updateable?
       (user.try(:commission_group).try(:id) || 1) < subscription.plan.commission_group_id
     end
  end

end
