module AppServices
  class CustomerService

    def initialize(params)
      @user     = params[:customer_params][:user]
      @token    = params[:customer_params][:token]
      @account  = @user.account
    end

    def call
      if @account.stripe_customer_id.present?
        # @todo verify customer exists on stripe before returning success
        OpenStruct.new({success?: true, payload: @account.stripe_customer_id})
      else
        if find_by_email.success? && find_by_email.payload
          OpenStruct.new({success?: true, payload: @account.stripe_customer_id})
        else
          create_customer
        end
      end
    end

    private

      attr_reader :user, :token, :account

      def find_by_email
        result ||= StripeServices::RetrieveCustomerByEmail.new({email: user.email }).call
        handle_result(result)
      end

      def create_customer
        result ||= StripeServices::CreateCustomer.new({ customer_params:{email:user.email, source: token} }).call
        handle_result(result)
      end

      def handle_result(result)
        if result.success?
          account.update_column(:stripe_customer_id, result.payload.id)
          OpenStruct.new({success?: true, payload: account.stripe_customer_id})
        else
          OpenStruct.new({success?: false, error: result&.error})
        end
      end

  end
end
