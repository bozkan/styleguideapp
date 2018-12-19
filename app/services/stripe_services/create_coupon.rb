module StripeServices

  class CreateCoupon

    def initialize(params)
      @coupon_params  = params[:coupon_params]
    end

    def call
      coupon = Stripe::Coupon.create(@coupon_params)
    rescue Stripe::StripeError => e
      OpenStruct.new({success?: false, error: e})
    else
      OpenStruct.new({success?: true, payload: coupon})
    end

  end

end
