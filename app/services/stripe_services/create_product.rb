module StripeServices

  class CreateProduct

    def initialize(params)
      @product_params  = params[:product_params]
      @stripe_account  = params[:stripe_account]
    end

    def call
      product = Stripe::Product.create(@product_params,{stripe_account:@stripe_account})
    rescue Stripe::StripeError => e
      OpenStruct.new({success?: false, error: e})
    else
      OpenStruct.new({success?: true, payload: product})
    end

  end

end
