module Qualtrics::API
  class User < BaseModel
    attribute :id
    attribute :username
    attribute :first_name
    attribute :last_name
    attribute :user_type
    attribute :division_id
    attribute :status
    attribute :language
    # attribute :permissions
    attribute :organization_id
    attribute :unsubscribed
    attribute :account_creation_date
    attribute :account_expiration_date
    attribute :password_last_changed_date
    attribute :password_expiration_date
    attribute :last_login_date
    attribute :response_counts

    # Create only attributes
    attribute :password
    attribute :email

    ##
    # Make the model serializeable by ActiveModelSerializer
    #
    # @return [OpenStruct]
    #
    def self.model_name
      OpenStruct.new(name: "Qualtrics::API::MailingList",
                     klass: self,
                     singular: "qualtrics_user",
                     plural: "qualtrics_users",
                     element: "user",
                     human: "user",
                     collection: "qualtrics/users",
                     param_key: "qualtrics_users",
                     i18n_key: "qualtrics/users",
                     route_key: "qualtrics_users",
                     singular_route_key: "qualtrics_user")
    end
  end
end
