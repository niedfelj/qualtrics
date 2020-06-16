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
        r.raw                       = response 
        r.values                    = response["values"]
        r.labels                    = response["labels"]
        r.displayed_fields          = response["displayedFields"]
        r.displayed_values          = response["displayedValues"]
        
        values = response["values"]
        r.response_set              = values["responseSet"]
        r.ip_address                = values["ipAddress"]
        r.start_date                = values["startDate"]
        r.end_date                  = values["endDate"]
        r.last_name                 = values["recipientLastName"]
        r.first_name                = values["recipientFirstName"]
        r.email                     = values["recipientEmail"]
        r.phone_number              = values["Phone Number"]
        r.phone_country             = values["Phone Country"]
        r.country                   = values["Country"]
        r.external_data_reference   = values["externalDataReference"]
        r.finished                  = values["finished"]
        r.status                    = values["status"]
        r.location_latitude         = values["locationLatitude"]
        r.location_longitude        = values["locationLongitude"]
        r.location_accuracy         = values["locationAccuracy"]
        r.user_language             = values["userLanguage"]
        r.distribution_channel      = values["distributionChannel"]

        r.questions = {}

        values.keys.grep(/QID([0-9xy_]+)/).each do |key|
          r.questions[key] = values[key]
        end

        responses << r
      end

      responses
    end
  end
end
