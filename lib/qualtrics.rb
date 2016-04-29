require "qualtrics/version"
require "resource_kit"
require "kartograph"
require "json"

module Qualtrics
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

  # Resources
  autoload :OrganizationResource,               'qualtrics/resources/organization_resource'
  autoload :DivisionResource,                   'qualtrics/resources/division_resource'
  autoload :GroupResource,                      'qualtrics/resources/group_resource'
  autoload :SurveyResource,                     'qualtrics/resources/survey_resource'
  autoload :UserResource,                       'qualtrics/resources/user_resource'
  autoload :LibraryMessageResource,             'qualtrics/resources/library_message_resource'

  # JSON Maps
  autoload :OrganizationMapping,                'qualtrics/mappings/organization_mapping'
  autoload :DivisionMapping,                    'qualtrics/mappings/division_mapping'
  autoload :GroupMapping,                       'qualtrics/mappings/group_mapping'
  autoload :SurveyMapping,                      'qualtrics/mappings/survey_mapping'
  autoload :ExpirationMapping,                  'qualtrics/mappings/expiration_mapping'
  autoload :UserMapping,                        'qualtrics/mappings/user_mapping'
  autoload :LibraryMessageMapping,              'qualtrics/mappings/library_message_mapping'

  # Utils
  autoload :ErrorHandlingResourceable,          'qualtrics/error_handling_resourceable'
  autoload :Kartograph,                         'qualtrics/utils/kartograph_optional_properties'

  # Errors
  autoload :ErrorMapping,                       'qualtrics/mappings/error_mapping'
  Error = Class.new(StandardError)
  FailedCreate = Class.new(Qualtrics::Error)
  FailedUpdate = Class.new(Qualtrics::Error)

  class RateLimitReached < Qualtrics::Error
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
