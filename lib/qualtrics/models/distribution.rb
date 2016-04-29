module Qualtrics
  class Distribution < BaseModel
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
    attribute :survey_link
    attribute :stats
  end
end
