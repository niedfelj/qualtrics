module Qualtrics::API
  class Distribution::SurveyLink < BaseModel
    attribute :survey_id
    attribute :expiration_date
    attribute :type

    ##
    # Make the model serializeable by ActiveModelSerializer
    #
    # @return [OpenStruct]
    #
    def self.model_name
      OpenStruct.new(name: "Qualtrics::API::MailingList",
                     klass: self,
                     singular: "qualtrics_distribution_survey_link",
                     plural: "qualtrics_distribution_survey_links",
                     element: "distribution_survey_link",
                     human: "distribution_survey_link",
                     collection: "qualtrics/distribution_survey_links",
                     param_key: "qualtrics_distribution_survey_links",
                     i18n_key: "qualtrics/distribution_survey_links",
                     route_key: "qualtrics_distribution_survey_links",
                     singular_route_key: "qualtrics_distribution_survey_link")
    end
  end
end
