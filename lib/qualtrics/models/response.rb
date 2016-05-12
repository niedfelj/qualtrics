module Qualtrics
  class Response < BaseModel
    attribute :id
    attribute :response_set
    attribute :ip_address
    attribute :start_date
    attribute :recipient_last_name
    attribute :recipient_first_name
    attribute :recipient_email
    attribute :external_data_reference
    attribute :finished
    attribute :status
    attribute :location_latitude
    attribute :location_longitude
    attribute :location_accuracy
    attribute :questions
  end
end
