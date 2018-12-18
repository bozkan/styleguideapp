class FontsController < ApplicationController

  layout 'brand'
  before_action :set_font, only: [:show, :edit, :update, :destroy]

  # GET /fonts
  def index
    @fonts = Font.all
  end

  # GET /fonts/1
  def show
  end

  # GET /fonts/new
  def new
    @font = Font.new
  end

  # GET /fonts/1/edit
  def edit
  end

  # POST /fonts
  def create
    @font = Font.new(font_params)

    if @font.save
      redirect_to @font, success: 'Font was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /fonts/1
  def update
    if @font.update(font_params)
      redirect_to @font, success: 'Font was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /fonts/1
  def destroy
    @font.destroy
    redirect_to fonts_url, success: 'Font was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_font
      @font = Font.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def font_params
      params.require(:font).permit(:brand_id, :name, :size, :line_height, :weight)
    end
end
