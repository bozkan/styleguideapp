module AppServices
  class SubscriptionService

    def initialize(params)
      @subscription     = params[:subscription_params][:subscription]
      @token            = params[:subscription_params][:token]
      @plan             = @subscription.plan
      @account          = @subscription.account
      @user             = @account.owner
    end

    def call

      # create or find customer
      customer ||= AppServices::CustomerService.new({customer_params: {user:@user, token:@token}}).call

      if customer && customer.success?

        subscription ||= StripeServices::CreateSubscription.new({subscription_params:{customer: customer.payload,items:[subscription_items]}}).call

        if subscription && subscription.success?
          @subscription.update_attributes(
            status:'active',
            stripe_id: subscription.payload.id,
            expiration:Time.at(subscription.payload.current_period_end).to_datetime
          )
          OpenStruct.new({success?: true, payload: subscription.payload})
        else
          handle_error(subscription&.error)
        end

      else
        handle_error(customer&.error)
      end

    end

    private

      attr_reader :plan

      def subscription_items
        base_plan
      end

      def base_plan
        [{ plan: plan.stripe_id }]
      end

      def handle_error(error)
        OpenStruct.new({success?: false, error: error})
      end
  end
end
