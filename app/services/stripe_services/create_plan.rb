module StripeServices

  class CreatePlan

    def initialize(params)
      @plan_params    = params[:plan_params]
    end

    def call
      plan = Stripe::Plan.create(@plan_params)
    rescue Stripe::StripeError => e
      OpenStruct.new({success?: false, error: e})
    else
      OpenStruct.new({success?: true, payload: plan})
    end

  end

end
