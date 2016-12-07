module Qualtrics::API
  class Distribution::Recipients < BaseModel
    attribute :mailing_list_id
    attribute :distribution_recipient_id
    attribute :contact_id

    ##
    # Make the model serializeable by ActiveModelSerializer
    #
    # @return [OpenStruct]
    #
    def self.model_name
      OpenStruct.new(name: "Qualtrics::API::MailingList",
                     klass: self,
                     singular: "qualtrics_distribution_recipient",
                     plural: "qualtrics_distribution_recipients",
                     element: "distribution_recipient",
                     human: "distribution_recipient",
                     collection: "qualtrics/distribution_recipients",
                     param_key: "qualtrics_distribution_recipients",
                     i18n_key: "qualtrics/distribution_recipients",
                     route_key: "qualtrics_distribution_recipients",
                     singular_route_key: "qualtrics_distribution_recipient")
    end
  end
end
