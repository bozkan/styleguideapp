module StripeServices

  class CreateInvoiceItem

    def initialize(params)
      @item_params    = params[:item_params]
    end

    def call
      item = Stripe::InvoiceItem.create(@item_params)
    rescue Stripe::StripeError => e
      OpenStruct.new({success?: false, error: e})
    else
      OpenStruct.new({success?: true, payload: item})
    end

  end

end
