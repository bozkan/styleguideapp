class BrandsController < ApplicationController

  layout 'brand'

  def show
    @brand = current_tenant
  end

end
