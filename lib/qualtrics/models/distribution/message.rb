module Qualtrics::API
  class Distribution::Message < BaseModel
    attribute :message_id
    attribute :library_id
    attribute :message_text

    ##
    # Make the model serializeable by ActiveModelSerializer
    #
    # @return [OpenStruct]
    #
    def self.model_name
      OpenStruct.new(name: "Qualtrics::API::MailingList",
                     klass: self,
                     singular: "qualtrics_distribution_message",
                     plural: "qualtrics_distribution_messages",
                     element: "distribution_message",
                     human: "distribution_message",
                     collection: "qualtrics/distribution_messages",
                     param_key: "qualtrics_distribution_messages",
                     i18n_key: "qualtrics/distribution_messages",
                     route_key: "qualtrics_distribution_messages",
                     singular_route_key: "qualtrics_distribution_message")
    end
  end
end
