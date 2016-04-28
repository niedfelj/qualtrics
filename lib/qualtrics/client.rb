require 'faraday'

module Qualtrics
  class Client
    QUALTRICS_API = 'https://osu.az1.qualtrics.com'

    attr_reader :api_token

    def initialize(options = {})
      @api_token = options[:api_token]
    end

    def connection
      Faraday.new(connection_options) do |req|
        req.adapter :net_http
      end
    end

    def self.resources
      {
        organization: OrganizationResource,
        # divisions: DivisionResource,
        # groups: GroupResource,
        # users: UserResource,
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
        url: QUALTRICS_API,
        headers: {
          content_type: 'application/json',
          X_API_TOKEN: api_token
        }
      }
    end
  end
end
