class StripeController < ApplicationController

  protect_from_forgery :except => :process_webhook
  skip_before_action :verify_authenticity_token, :authorize!, :redirect_public
  before_action :verify_event

  def process_webhook
    case @event.type
    when 'invoice.payment_succeeded'
      WebhookServices::PaymentSucceeded.new({event:@event}).call unless webhook_event_exists?
    when 'invoice.payment_failed'
      WebhookServices::PaymentFailed.new({event:@event}).call unless webhook_event_exists?
    when 'customer.subscription.deleted'
      WebhookServices::SubscriptionDeleted.new({event:@event}).call unless webhook_event_exists?
    else
      Rails.logger.warn "Unhandled Webhook #{@event.type}"
    end
    render status: :ok, json: 'success'
  end

  private

    def verify_event
      payload     = request.body.read
      sig_header  = request.env['HTTP_STRIPE_SIGNATURE']
      @event      = Stripe::Webhook.construct_event(payload, sig_header, endpoint_secret)
    rescue JSON::ParserError => e
      head 403
      return
    rescue Stripe::SignatureVerificationError => e
      head 403
      return
    end

    def endpoint_secret
      ENV['STRIPE_WEBHOOK_KEY']
    end

    def webhook_event_exists?
      WebhookEvent.exists?(event_id:@event.id)
    end
end
