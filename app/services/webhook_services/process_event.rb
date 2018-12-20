module WebhookServices

  class ProcessEvent

    def initialize(params)
      @event   = params[:event]
    end

    def call
      WebhookEvent.create!(webhook_id:@event.id, api_version:@event.api_version)
    end

  end

end
