module Qualtrics
  class Survey < BaseModel
    attribute :id
    attribute :name
    attribute :owner_id
    attribute :last_modified
    attribute :is_active
    attribute :organization_id
  end
end
