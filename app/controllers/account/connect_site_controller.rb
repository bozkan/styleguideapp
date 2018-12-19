class Account::ConnectSiteController < AccountsController

  before_action :set_brand

  def connect
    respond_to do |format|
      if @brand.update(brand_params)
        result ||= AppServices::ConnectSite.new({website:@brand.website}).call
        @result = result && result.success? ? result.payload : result.error

        format.html{  redirect_to edit_account_brand_path(@brand), success: 'Connected!' }
        format.js{}
      else
        format.html{ render :edit }
        format.js{}
      end
    end
  end

  def connect_style
    @stylesheet = params.dig('brand','stylesheet_url')
    result = AppServices::ConnectSiteStyle.new({brand:@brand, stylesheet:@stylesheet}).call

    respond_to do |format|
      if result && result.success?
        format.html { redirect_to account_brands_path, success: "You're all set!" }
        format.js {}
      else
        format.html { flash[:warning] = 'There was a problem saving the stylesheet URL.'
                      redirect_to edit_account_brand_path(@brand)
                    }
        format.js{}
      end
    end
  end

  private

    # Only allow a trusted parameter "white list" through.
    def brand_params
      params.require(:brand).permit(:website, :stylesheet_url)
    end

    def set_brand
      @brand = @account.brands.where(id:params[:id])&.first
    end

end
