class ColorsController < ApplicationController
  layout 'brand'
  before_action :set_color, only: [:show, :edit, :update, :destroy]

  # GET /colors
  def index
    @colors     = Color.all
    @categories = ColorCategory.includes(:colors).all
  end

  # GET /colors/1
  def show
  end

  # GET /colors/new
  def new
    @color = Color.new
  end

  # GET /colors/1/edit
  def edit
  end

  # POST /colors
  def create
    @color = Color.new(color_params)

    if @color.save
      redirect_to colors_path, success: 'Color was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /colors/1
  def update
    if @color.update(color_params)
      redirect_to colors_path, success: 'Color was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /colors/1
  def destroy
    @color.destroy
    redirect_to colors_url, success: 'Color was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_color
      @color = Color.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def color_params
      params.require(:color).permit(:hex, :color_category_id)
    end
end
