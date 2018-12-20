class Account::SubscriptionsController < AccountsController

  def index
    @subscription = @account.subscription
  end

end
