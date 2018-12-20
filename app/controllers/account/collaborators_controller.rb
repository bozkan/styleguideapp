class Account::CollaboratorsController < AccountsController

  def index
    @invite = @account.invites.new
    @invites = @account.invites.order(created_at: :desc)
  end

end
