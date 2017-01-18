module Qualtrics::API
  class Distribution::Headers < BaseModel
    attribute :from_email
    attribute :from_name
    attribute :reply_to_email
    attribute :subject

    ##
    # Make the model serializeable by ActiveModelSerializer
    #
    # @return [OpenStruct]
    #
    def self.model_name
      OpenStruct.new(name: "Qualtrics::API::MailingList",
                     klass: self,
                     singular: "qualtrics_distribution_header",
                     plural: "qualtrics_distribution_headers",
                     element: "distribution_header",
                     human: "distribution_header",
                     collection: "qualtrics/distribution_headers",
                     param_key: "qualtrics_distribution_headers",
                     i18n_key: "qualtrics/distribution_headers",
                     route_key: "qualtrics_distribution_headers",
                     singular_route_key: "qualtrics_distribution_header")
    end
  end
end
