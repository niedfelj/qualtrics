module Qualtrics
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
  end
end
