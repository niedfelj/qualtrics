module Qualtrics::API
  class Division < BaseModel
    attribute :id
    attribute :organization_id
    attribute :creator_id
    attribute :name
    attribute :creation_date
    attribute :status
    attribute :response_counts
    attribute :division_admins
    # attribute :permissions

    ##
    # Make the model serializeable by ActiveModelSerializer
    #
    # @return [OpenStruct]
    #
    def self.model_name
      OpenStruct.new(name: "Qualtrics::API::MailingList",
                     klass: self,
                     singular: "qualtrics_division",
                     plural: "qualtrics_divisions",
                     element: "division",
                     human: "division",
                     collection: "qualtrics/divisions",
                     param_key: "qualtrics_divisions",
                     i18n_key: "qualtrics/divisions",
                     route_key: "qualtrics_divisions",
                     singular_route_key: "qualtrics_division")
    end
  end
end
