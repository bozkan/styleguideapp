module StripeServices

  class CreateCoupon

    def initialize(params)
      @coupon_params  = params[:coupon_params]
      @stripe_account = params[:stripe_account]
    end

    def call
      coupon = Stripe::Coupon.create(@coupon_params,{stripe_account:@stripe_account})
    rescue Stripe::StripeError => e
      OpenStruct.new({success?: false, error: e})
    else
      OpenStruct.new({success?: true, payload: coupon})
    end

  end

end
