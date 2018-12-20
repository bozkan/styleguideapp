class Account::InvitesController < AccountsController

  def create
    @invite = @account.invites.new(invite_params)

    if @invite.save!
      redirect_to account_collaborators_path, success:'Invitation successfully sent!'
    else
      render :index
    end
  end

  def destroy
    @invite = @account.invites.where(id:params[:id]).first
    if @invite.destroy
      redirect_to account_collaborators_path, success:'Invitation successfully destroyed!'
    else
      render :index
    end
  end

  def resend
  end

  private

    def invite_params
      params.require(:invite).permit(:email, :brand_id)
    end
end
