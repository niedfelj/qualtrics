require "faraday"

module Qualtrics::API
  class Client
    attr_reader :api_token, :data_center_id

    def initialize(options = {})
      @api_token = options[:api_token]
      @data_center_id = options[:data_center_id]
    end

    def connection
      Faraday.new(connection_options) do |req|
        #req.response :logger 
        req.adapter :net_http
      end
    end

    def self.resources
      {
        organization: OrganizationResource,
        divisions: DivisionResource,
        groups: GroupResource,
        users: UserResource,
        surveys: SurveyResource,
        response_exports: ResponseExportResource,
        response_imports: ResponseImportResource,
        library_messages: LibraryMessageResource,
        distributions: DistributionResource,
        mailing_lists: MailingListResource
      }
    end

    def method_missing(name, *args, &block)
      if self.class.resources.keys.include?(name)
        resources[name] ||= self.class.resources[name].new(connection: connection)
        resources[name]
      else
        super
      end
    end

    def resources
      @resources ||= {}
    end

    private

      def connection_options
        {
          url: "https://#{@data_center_id}.qualtrics.com",
          headers: {
            content_type: "application/json",
            X_API_TOKEN: api_token
          }
        }
      end
  end
end
