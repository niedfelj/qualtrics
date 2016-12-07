module Qualtrics
  class MailingList < BaseModel
    include ::ActiveModel::Serialization

    attribute :id
    attribute :library_id
    attribute :name
    attribute :category

    ##
    # Make the model serializeable by ActiveModelSerializer
    #
    # @return [OpenStruct]
    #
    def self.model_name
      OpenStruct.new(name: "Qualtrics::mailing_list",
                     klass: self,
                     singular: "qualtrics_mailing_list",
                     plural: "qualtrics_mailing_lists",
                     element: "mailing_list",
                     human: "mailing_list",
                     collection: "qualtrics/mailing_lists",
                     param_key: "qualtrics_mailing_lists",
                     i18n_key: "qualtrics/mailing_lists",
                     route_key: "qualtrics_mailing_lists",
                     singular_route_key: "qualtrics_mailing_list")
    end
  end
end
