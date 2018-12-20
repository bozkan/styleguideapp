class Account::PaymentsController < AccountsController

  def show
    @payment = @account.payments.where(id: params[:payment_id]).first
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "Payment",
        template: "account/payments/pdf.html.erb",
        layout: 'pdf.html',
        dpi: 300,
        page_width: 1200
      end
    end
  end

end
