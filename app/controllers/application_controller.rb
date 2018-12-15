class ApplicationController < ActionController::Base
  add_flash_types :success, :warning, :danger, :info
  set_current_tenant_by_subdomain(:brand, :subdomain)

  before_action :redirect_public

  private

    def redirect_public
      unless ['index','show'].include?(action_name)
        unless user_signed_in?
          redirect_to brand_root_path
        end
      end
    end
end
