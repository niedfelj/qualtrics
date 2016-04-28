module Qualtrics
  class Organization < BaseModel
    attribute :id
    attribute :name
    attribute :base_url
    attribute :type
    attribute :status
    attribute :stats
  end
end
