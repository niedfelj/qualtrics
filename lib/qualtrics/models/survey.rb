module Qualtrics
  class Survey < BaseModel
    attribute :id
    attribute :name
    attribute :owner_id
    attribute :organization_id
    attribute :creation_date
    attribute :last_modified
    attribute :is_active
    attribute :expiration
    attribute :questions
    attribute :export_column_map
    attribute :blocks
    attribute :flow
    attribute :embedded_data
    attribute :response_counts
  end
end
