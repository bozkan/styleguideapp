class SettingsController < ApplicationController
  layout 'brand'

  before_action :authenticate_user!

  def index
    @brand = current_tenant
  end

  def update
    if current_tenant.update_attributes(brand_params)
      redirect_to settings_path, success:'Settings Updated!'
    else
      redirect_to settings_path, error:'Error updating settings'
    end
  end

  private

    def brand_params
      params.require(:brand).permit(:stylesheet_url)
    end
end
