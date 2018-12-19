module AppServices

  class ConnectSiteStyle

    def initialize(params)
      @brand      = params[:brand]
      @stylesheet = params[:stylesheet]
    end

    def call
      save_url
    end

    attr_reader :brand, :stylesheet

    def save_url
      if brand.update_attributes(stylesheet_url: url)
        OpenStruct.new({success?:true})
      else
        OpenStruct.new({success?:false})
      end
    end

    def url
      if ['http', 'https'].include?(stylesheet)
        stylesheet
      else
        "#{brand.website}#{stylesheet}"
      end
    end

  end

end
