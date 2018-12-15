class Account::BrandsController < AccountsController
  before_action :set_brand, only: [:show, :edit, :update, :destroy]

  # GET /brands
  def index
    @brands = @account.brands
  end

  # GET /brands/1
  def show
  end

  # GET /brands/new
  def new
    @brand = @account.brands.new
  end

  # GET /brands/1/edit
  def edit
  end

  # POST /brands
  def create
    @brand = @account.brands.new(brand_params)

    if @brand.save
      redirect_to account_brands_path, success: 'brand was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /brands/1
  def update
    if @brand.update(brand_params)
      redirect_to account_brands_path, success: 'brand was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /brands/1
  def destroy
    @brand.destroy
    redirect_to brands_url, notice: 'brand was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_brand
      @brand = @account.brands.where(id:params[:id])&.first
    end

    # Only allow a trusted parameter "white list" through.
    def brand_params
      params.require(:brand).permit(:name, :subdomain)
    end
end
