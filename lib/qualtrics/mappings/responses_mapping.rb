module Qualtrics::API
  class ResponsesMapping
    # Maps each of the responses to a Qualtrics::API::Response model
    #
    # @return [Qualtrics::API::Response]
    def self.from_json_or_xml(serialized_response, f_type)
      case f_type
      when :json
        responses_hash = JSON.parse(serialized_response)
        unmapped_responses = responses_hash["responses"]
      when :xml
        responses_hash = Hash.from_xml(serialized_response)
        unmapped_responses = responses_hash["xml"]["Response"]
      end

      responses = []
      unmapped_responses.each do |response|

        r = Response.new
        r.id                        = response["responseId"]

        response = response["values"]
        r.response_set              = response["responseSet"]
        r.ip_address                = response["ipAddress"]
        r.start_date                = response["startDate"]
        r.end_date                  = response["endDate"]
        r.last_name                 = response["recipientLastName"]
        r.first_name                = response["recipientFirstName"]
        r.email                     = response["recipientEmail"]
        r.phone_number              = response["Phone Number"]
        r.country                   = response["Country"]
        r.external_data_reference   = response["externalDataReference"]
        r.finished                  = response["finished"]
        r.status                    = response["status"]
        r.location_latitude         = response["locationLatitude"]
        r.location_longitude        = response["locationLongitude"]
        r.location_accuracy         = response["locationAccuracy"]
        r.user_language             = response["userLanguage"]
        r.distribution_channel      = response["distributionChannel"]

        r.questions = {}
        response.keys.grep(/Q([0-9xy_]+)/).each do |key|
          r.questions[key] = response[key]
        end

        responses << r
      end

      responses
    end
  end
end
