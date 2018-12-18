module StripeServices

  class CreateInvoiceItem

    def initialize(params)
      @item_params    = params[:item_params]
      @stripe_account = params[:stripe_account]
    end

    def call
      item = Stripe::InvoiceItem.create(@item_params,{stripe_account:@stripe_account})
    rescue Stripe::StripeError => e
      OpenStruct.new({success?: false, error: e})
    else
      OpenStruct.new({success?: true, payload: item})
    end

  end

end
