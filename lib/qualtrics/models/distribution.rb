module Qualtrics::API
  class Distribution < BaseModel
    include ::ActiveModel::Serialization

    attribute :id
    attribute :parent_distribution_id
    attribute :owner_id
    attribute :organization_id
    attribute :request_status
    attribute :request_type
    attribute :send_date
    attribute :created_date
    attribute :modified_date
    attribute :headers
    attribute :recipients
    attribute :message
    attribute :distribution_link
    attribute :stats

    ##
    # Make the model serializeable by ActiveModelSerializer
    #
    # @return [OpenStruct]
    #
    def self.model_name
      OpenStruct.new(name: "Qualtrics::API::Distribution",
                     klass: self,
                     singular: "qualtrics_distribution",
                     plural: "qualtrics_distributions",
                     element: "distribution",
                     human: "distribution",
                     collection: "qualtrics/distributions",
                     param_key: "qualtrics_distributions",
                     i18n_key: "qualtrics/distributions",
                     route_key: "qualtrics_distributions",
                     singular_route_key: "qualtrics_distribution")
    end
  end
end
