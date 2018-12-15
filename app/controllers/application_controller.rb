class ApplicationController < ActionController::Base
  add_flash_types :success, :warning, :danger, :info
  set_current_tenant_by_subdomain(:brand, :subdomain)

  before_action :redirect_public, unless: :devise_controller?
  layout :set_layout

  private

    def redirect_public
      unless ['index','show'].include?(action_name)
        if user_signed_in? && !authorized_for_brand?
          redirect_to brand_root_path
        end
      end
    end

   def set_layout
     if devise_controller?
       'auth'
     else
       request.subdomain.present? ? 'brand' : 'application'
     end
   end

   def authorized_for_brand?
     current_user.account.brands.include?(current_tenant)
   end

end
