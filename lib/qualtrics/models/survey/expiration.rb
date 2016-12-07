module Qualtrics::API
  class Survey::Expiration < BaseModel
    attribute :start_date
    attribute :end_date

    ##
    # Make the model serializeable by ActiveModelSerializer
    #
    # @return [OpenStruct]
    #
    def self.model_name
      OpenStruct.new(name: "Qualtrics::API::MailingList",
                     klass: self,
                     singular: "qualtrics_survey_expiration",
                     plural: "qualtrics_survey_expirations",
                     element: "survey_expiration",
                     human: "survey_expiration",
                     collection: "qualtrics/survey_expirations",
                     param_key: "qualtrics_survey_expirations",
                     i18n_key: "qualtrics/survey_expirations",
                     route_key: "qualtrics_survey_expirations",
                     singular_route_key: "qualtrics_survey_expiration")
    end
  end
end
