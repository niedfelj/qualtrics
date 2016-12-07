module Qualtrics::API
  class Group < BaseModel
    attribute :id
    attribute :type
    attribute :organization_id
    attribute :division_id
    attribute :name
    attribute :all_users
    attribute :creation_date
    attribute :creator_id

    ##
    # Make the model serializeable by ActiveModelSerializer
    #
    # @return [OpenStruct]
    #
    def self.model_name
      OpenStruct.new(name: "Qualtrics::API::MailingList",
                     klass: self,
                     singular: "qualtrics_group",
                     plural: "qualtrics_groups",
                     element: "group",
                     human: "group",
                     collection: "qualtrics/groups",
                     param_key: "qualtrics_groups",
                     i18n_key: "qualtrics/groups",
                     route_key: "qualtrics_groups",
                     singular_route_key: "qualtrics_group")
    end
  end
end
