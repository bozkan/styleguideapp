class InvitesController < ApplicationController

  before_action :verify_invite, only: :index
  skip_before_action :redirect_public, only: :claim

  def index
    @user = @invite.account.users.build
  end

  def claim
    @account = current_tenant.account
    @user = @account.users.new(user_params)

    if @user.save
      sign_in @user
      @account.users << @user
      @account.save
      Invite.where(email:@user.email).destroy_all
      redirect_to brand_root_path, success:'Invite claimed!'
    else
      render :index, warning:'Something went wrong claiming the invite.'
    end
  end

  private

    def verify_invite
      if params[:invite_token]
        @invite  = Invite.find_by_token(params[:invite_token])
        unless @invite.present?
          redirect_to root_path, notice:"No invite found for this brand with that token."
        end
      else
        redirect_to root_path, notice:"No token detected."
      end
    end

    def user_params
      params.require(:user).permit(:email, :password)
    end
end
