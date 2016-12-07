module Qualtrics::API
  class LibraryMessage < BaseModel
    attribute :id
    attribute :category
    attribute :description
    attribute :messages

    ##
    # Make the model serializeable by ActiveModelSerializer
    #
    # @return [OpenStruct]
    #
    def self.model_name
      OpenStruct.new(name: "Qualtrics::API::MailingList",
                     klass: self,
                     singular: "qualtrics_library_message",
                     plural: "qualtrics_library_messages",
                     element: "library_message",
                     human: "library_message",
                     collection: "qualtrics/library_messages",
                     param_key: "qualtrics_library_messages",
                     i18n_key: "qualtrics/library_messages",
                     route_key: "qualtrics_library_messages",
                     singular_route_key: "qualtrics_library_message")
    end
  end
end
