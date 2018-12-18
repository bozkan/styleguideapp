module StripeServices

  class DeauthorizeAccount

    def initialize(params)
      @stripe_account_id = params[:stripe_account_id]
    end

    def call
      account = Stripe::Account.retrieve(@stripe_account_id)
      account.deauthorize(Rails.application.credentials[:stripe_test_connect_client_id])
    rescue Stripe::StripeError => e
      OpenStruct.new({success?: false, error: e})
    else
      OpenStruct.new({success?: true, payload: account})
    end

  end

end
