module Qualtrics
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
  end
end
