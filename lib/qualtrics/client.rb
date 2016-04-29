require 'faraday'

module Qualtrics
  class Client
    attr_reader :api_token, :data_center_id

    def initialize(options = {})
      @api_token = options[:api_token]
      @data_center_id = options[:data_center_id]
    end

    def connection
      Faraday.new(connection_options) do |req|
        req.adapter :net_http
      end
    end

    def self.resources
      {
        organization: OrganizationResource,
        divisions: DivisionResource,
        # groups: GroupResource,
        users: UserResource,
        surveys: SurveyResource
        # responses: ResponseResource,
        # response_exports: ResponseExportsResource,
        # response_imports: ResponseImportsResource,
        # message_library: MessageLibraryResource,
        # distributions: DistributionResource,
        # mailing_lists: MailingListResource
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
          content_type: 'application/json',
          X_API_TOKEN: api_token
        }
      }
    end
  end
end
