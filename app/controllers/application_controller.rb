class ApplicationController < ActionController::Base
  add_flash_types :success, :warning, :danger, :info
  set_current_tenant_by_subdomain(:brand, :subdomain)
end
