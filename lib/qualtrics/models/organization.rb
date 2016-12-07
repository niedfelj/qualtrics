module Qualtrics::API
  class Organization < BaseModel
    attribute :id
    attribute :name
    attribute :base_url
    attribute :type
    attribute :status
    attribute :stats

    ##
    # Make the model serializeable by ActiveModelSerializer
    #
    # @return [OpenStruct]
    #
    def self.model_name
      OpenStruct.new(name: "Qualtrics::API::MailingList",
                     klass: self,
                     singular: "qualtrics_organization",
                     plural: "qualtrics_organizations",
                     element: "organization",
                     human: "organization",
                     collection: "qualtrics/organizations",
                     param_key: "qualtrics_organizations",
                     i18n_key: "qualtrics/organizations",
                     route_key: "qualtrics_organizations",
                     singular_route_key: "qualtrics_organization")
    end
  end
end
