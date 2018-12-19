class RegisterController < ApplicationController

  layout 'auth'

  before_action :redirect_register, if: :user_signed_in?
  skip_before_action :redirect_public
  http_basic_authenticate_with name: 'beta', password: '1234', if: :beta?

  def index
    @account = Account.new
    unless user_signed_in?
      @account.build_owner
      @account.build_subscription
    end
  end

  def create
    @account = Account.new(account_params)

    if @account.save

      result = AppServices::SubscriptionService.new({subscription_params: {subscription:@account.subscription, token:params[:stripeToken]}}).call

      if result && result.success?
        sign_in(@account.owner)
        redirect_to new_account_brand_path, success: 'Registration succesfull!'
      else
        @account.destroy
        redirect_to register_path, warning: "Registration Error #{result.error}"
      end
    else
      render :index, warning: 'Account not created.'
    end
  end

  private

    def beta?
      Rails.env.production?
    end

    def account_params
      params.require(:account).permit(:owner_id, :newsletter, :terms, owner_attributes: [:email, :password], subscription_attributes:[:subscription_plan_id])
    end

    def redirect_register
      redirect_to root_path
    end

end
