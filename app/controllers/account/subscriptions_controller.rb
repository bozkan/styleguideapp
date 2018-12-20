class Account::SubscriptionsController < AccountsController

  def index
    @subscription = @account.subscription
  end

  def update_card

  end

  def cancel
    result = AppServices::CancellationService.new({subscription:@account.subscription}).call
    if result && result.success?
      redirect_to account_subscriptions_path, success: 'Subscription was successfully cancelled.'
    else
      redirect_to account_subscriptions_path, warning: "Something went wrong. #{result.error}"
    end
  end

  def reactivate
    result = StripeServices::ReactivateSubscription.new({subscription_id:@account.subscription.stripe_id}).call
    if result && result.success? && @account.subscription.update_attributes!(status:'active')
      redirect_to account_subscriptions_path, success: 'Subscription was successfully reactivated.'
    else
      redirect_to account_subscriptions_path, warning: "Unable to reactivate subscription. #{result&.error}"
    end
  end

end
