module ApplicationHelper

  def current_user_authorized_for_brand?
    user_signed_in? &&
    current_tenant &&
    current_user.account.brands.exists? &&
    current_user.account.brands.include?(current_tenant)
  end

end
