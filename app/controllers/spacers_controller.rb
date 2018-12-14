class SpacersController < ApplicationController
  layout 'brand'
  before_action :set_spacer, only: [:show, :edit, :update, :destroy]

  # GET /spacers
  def index
    @spacers = Spacer.all
  end

  # GET /spacers/1
  def show
  end

  # GET /spacers/new
  def new
    @spacer = Spacer.new
  end

  # GET /spacers/1/edit
  def edit
  end

  # POST /spacers
  def create
    @spacer = Spacer.new(spacer_params)

    if @spacer.save
      redirect_to @spacer, notice: 'Spacer was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /spacers/1
  def update
    if @spacer.update(spacer_params)
      redirect_to @spacer, notice: 'Spacer was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /spacers/1
  def destroy
    @spacer.destroy
    redirect_to spacers_url, notice: 'Spacer was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_spacer
      @spacer = Spacer.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def spacer_params
      params.require(:spacer).permit(:brand_id, :size)
    end
end
