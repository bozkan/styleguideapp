module AppServices
  class CancellationService

    def initialize(params)
      @subscription      = params[:subscription]
    end

    def call
      cancel_with_merchant
    end

    private

      attr_reader :subscription

      def cancel_with_merchant
        result = StripeServices::CancelSubscription.new({subscription_id:subscription.stripe_id}).call
        if result.success?
          cancel_locally
        else
          OpenStruct.new({success?:false, error: result.error})
        end
      end

      def cancel_locally
        if subscription.update_attributes(status:'canceled')
          notify_account_owner
          OpenStruct.new({success?:true})
        else
          OpenStruct.new({success?:false, error:"Canceled subscription with Stripe, but there was an error updating the subscription within the app."})
        end
      end

      def notify_account_owner
        #SubscriptionCancellationMailer.send_email(subscription.id).deliver_later
      end

  end
end
