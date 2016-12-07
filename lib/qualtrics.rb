require 'zip'
require 'json'
require 'kartograph'
require 'resource_kit'
require 'qualtrics/version'
require 'active_model'
require 'active_support/all'

module Qualtrics
  module API
    autoload :Client,                             'qualtrics/client'

    # Models
    autoload :BaseModel,                          'qualtrics/models/base_model'
    autoload :Organization,                       'qualtrics/models/organization'
    autoload :Division,                           'qualtrics/models/division'
    autoload :Group,                              'qualtrics/models/group'
    autoload :Survey,                             'qualtrics/models/survey'
      Survey.autoload :Expiration,                'qualtrics/models/survey/expiration'
    autoload :User,                               'qualtrics/models/user'
    autoload :LibraryMessage,                     'qualtrics/models/library_message'
    autoload :Distribution,                       'qualtrics/models/distribution'
      Distribution.autoload :Headers,             'qualtrics/models/distribution/headers'
      Distribution.autoload :Message,             'qualtrics/models/distribution/message'
      Distribution.autoload :Recipients,          'qualtrics/models/distribution/recipients'
      Distribution.autoload :SurveyLink,          'qualtrics/models/distribution/survey_link'
    autoload :ResponseExport,                     'qualtrics/models/response_export'
    autoload :Response,                           'qualtrics/models/response'
    autoload :MailingList,                        'qualtrics/models/mailing_list'
      MailingList.autoload :Contact,              'qualtrics/models/mailing_list/contact'

    # Resources
    autoload :OrganizationResource,               'qualtrics/resources/organization_resource'
    autoload :DivisionResource,                   'qualtrics/resources/division_resource'
    autoload :GroupResource,                      'qualtrics/resources/group_resource'
    autoload :SurveyResource,                     'qualtrics/resources/survey_resource'
    autoload :UserResource,                       'qualtrics/resources/user_resource'
    autoload :LibraryMessageResource,             'qualtrics/resources/library_message_resource'
    autoload :DistributionResource,               'qualtrics/resources/distribution_resource'
    autoload :ResponseExportResource,             'qualtrics/resources/response_export_resource'
    autoload :ResponseImportResource,             'qualtrics/resources/response_import_resource'
    autoload :MailingListResource,                'qualtrics/resources/mailing_list_resource'

    # JSON Maps
    autoload :OrganizationMapping,                'qualtrics/mappings/organization_mapping'
    autoload :DivisionMapping,                    'qualtrics/mappings/division_mapping'
    autoload :GroupMapping,                       'qualtrics/mappings/group_mapping'
    autoload :SurveyMapping,                      'qualtrics/mappings/survey_mapping'
    autoload :ExpirationMapping,                  'qualtrics/mappings/expiration_mapping'
    autoload :UserMapping,                        'qualtrics/mappings/user_mapping'
    autoload :LibraryMessageMapping,              'qualtrics/mappings/library_message_mapping'
    autoload :DistributionMapping,                'qualtrics/mappings/distribution_mapping'
    autoload :ResponseExportMapping,              'qualtrics/mappings/response_export_mapping'
    autoload :ResponsesMapping,                   'qualtrics/mappings/responses_mapping'
    autoload :MailingListMapping,                 'qualtrics/mappings/mailing_list_mapping'
    autoload :ContactMapping,                     'qualtrics/mappings/contact_mapping'

    # Utils
    autoload :ErrorHandlingResourceable,          'qualtrics/error_handling_resourceable'
    autoload :Kartograph,                         'qualtrics/utils/kartograph_optional_properties'

    # Errors
    autoload :ErrorMapping,                       'qualtrics/mappings/error_mapping'
    Error = Class.new(StandardError)
    FailedCreate = Class.new(Qualtrics::API::Error)
    FailedUpdate = Class.new(Qualtrics::API::Error)

    class RateLimitReached < Qualtrics::API::Error
      attr_accessor :reset_at
      attr_writer :limit, :remaining

      def limit
        @limit.to_i if @limit
      end

      def remaining
        @remaning.to_i if @remaning
      end
    end
  end

end
