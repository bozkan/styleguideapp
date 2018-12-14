class ColorCategoriesController < ApplicationController
  layout 'brand'
  before_action :set_color_category, only: [:show, :edit, :update, :destroy]

  # GET /color_categories
  def index
    @color_categories = ColorCategory.all
  end

  # GET /color_categories/1
  def show
  end

  # GET /color_categories/new
  def new
    @color_category = ColorCategory.new
  end

  # GET /color_categories/1/edit
  def edit
  end

  # POST /color_categories
  def create
    @color_category = ColorCategory.new(color_category_params)

    if @color_category.save
      redirect_to @color_category, notice: 'Color category was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /color_categories/1
  def update
    if @color_category.update(color_category_params)
      redirect_to @color_category, notice: 'Color category was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /color_categories/1
  def destroy
    @color_category.destroy
    redirect_to color_categories_url, notice: 'Color category was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_color_category
      @color_category = ColorCategory.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def color_category_params
      params.require(:color_category).permit(:brand_id, :name)
    end
end
