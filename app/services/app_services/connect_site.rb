module AppServices

  require 'nokogiri'
  require 'open-uri'

  class ConnectSite

    def initialize(params)
      @website = params[:website]
    end

    def call
      connect
    end

    private

      attr_reader :website

      def connect
        result = Nokogiri::HTML(open(website))
      rescue Nokogiri::Error => e
        OpenStruct.new({success?: false, error: e})
      else
        parse(result)
      end

      def parse(doc)
        links = []
        doc.css('head link').each do |tag|
          link = tag['href']
          links << link if (link && link.include?('.css'))
        end
        handle_results(links)
      end

      def handle_results(links)
        if links && links.kind_of?(Array)
          OpenStruct.new({success?:true, payload:links})
        else
          OpenStruct.new({success?:true, error:'No stylesheet links found.'})
        end
      end


  end

end
