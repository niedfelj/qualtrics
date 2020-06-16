module Qualtrics::API
  class Response < BaseModel
    include ::ActiveModel::Serialization

    attribute :id
    attribute :raw 
    attribute :values 
    attribute :labels
    attribute :displayed_fields 
    attribute :displayed_values
    attribute :response_set
    attribute :ip_address
    attribute :start_date
    attribute :end_date
    attribute :last_name
    attribute :first_name
    attribute :email
    attribute :phone_number
    attribute :phone_country
    attribute :country
    attribute :external_data_reference
    attribute :finished
    attribute :status
    attribute :location_latitude
    attribute :location_longitude
    attribute :location_accuracy
    attribute :user_language
    attribute :distribution_channel
    attribute :questions

    ##
    # Make the model serializeable by ActiveModelSerializer
    #
    # @return [OpenStruct]
    #
    def self.model_name
      OpenStruct.new(name: "Qualtrics::API::Response",
                     klass: self,
                     singular: "qualtrics_response",
                     plural: "qualtrics_responses",
                     element: "responses",
                     human: "response",
                     collection: "qualtrics/responses",
                     param_key: "qualtrics_responses",
                     i18n_key: "qualtrics/responses",
                     route_key: "qualtrics_responses",
                     singular_route_key: "qualtrics_response")
    end
  end
end
