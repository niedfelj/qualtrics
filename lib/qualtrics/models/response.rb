module Qualtrics
  class Response < BaseModel
    attribute :id
    attribute :response_set
    attribute :ip_address
    attribute :start_date
    attribute :end_date
    attribute :last_name
    attribute :first_name
    attribute :email
    attribute :external_data_reference
    attribute :finished
    attribute :status
    attribute :location_latitude
    attribute :location_longitude
    attribute :location_accuracy
    attribute :questions
  end
end
