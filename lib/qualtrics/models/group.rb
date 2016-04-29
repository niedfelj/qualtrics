module Qualtrics
  class Group < BaseModel
    attribute :id
    attribute :type
    attribute :organization_id
    attribute :division_id
    attribute :name
    attribute :all_users
    attribute :creation_date
    attribute :creator_id
  end
end
