module StripeServices

  class CreateProduct

    def initialize(params)
      @product_params  = params[:product_params]
    end

    def call
      product = Stripe::Product.create(@product_params)
    rescue Stripe::StripeError => e
      OpenStruct.new({success?: false, error: e})
    else
      OpenStruct.new({success?: true, payload: product})
    end

  end

end
