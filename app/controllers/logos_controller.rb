class LogosController < ApplicationController
  layout 'brand'
  before_action :set_logo, only: [:show, :edit, :update, :destroy]

  # GET /logos
  def index
    @logos = Logo.all
  end

  # GET /logos/1
  def show
  end

  # GET /logos/new
  def new
    @logo = Logo.new
  end

  # GET /logos/1/edit
  def edit
  end

  # POST /logos
  def create
    @logo = Logo.new(logo_params)

    if @logo.save
      redirect_to @logo, success: 'Logo was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /logos/1
  def update
    if @logo.update(logo_params)
      redirect_to @logo, success: 'Logo was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /logos/1
  def destroy
    @logo.destroy
    redirect_to logos_url, success: 'Logo was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_logo
      @logo = Logo.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def logo_params
      params.require(:logo).permit(:file, :remove_file, :name, :description, :display_color)
    end
end
