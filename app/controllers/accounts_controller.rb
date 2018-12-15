class AccountsController < ApplicationController

  layout 'account'

  skip_before_action :redirect_public
  before_action :authenticate_user!, :set_account, :authenticate_owner

  def index

  end

  private

    def authenticate_owner
      redirect_to root_path unless @account && (current_user == @account.owner)
    end

    def set_account
      @account ||= current_user.account
    end

end
