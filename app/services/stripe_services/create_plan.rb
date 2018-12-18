module StripeServices

  class CreatePlan

    def initialize(params)
      @plan_params    = params[:plan_params]
      @stripe_account = params[:stripe_account]
    end

    def call
      plan = Stripe::Plan.create(@plan_params,{stripe_account:@stripe_account})
    rescue Stripe::StripeError => e
      OpenStruct.new({success?: false, error: e})
    else
      OpenStruct.new({success?: true, payload: plan})
    end

  end

end
