module Qualtrics
  class ResponsesMapping

    # Maps each of the responses to a Qualtrics::Response model
    #
    # @return [Qualtrics::Response]
    def self.from_json_or_xml(serialized_response, f_type)
      case f_type
      when :json
        responses_hash = JSON.parse(serialized_response)
        unmapped_responses = responses_hash['responses']
      when :xml
        responses_hash = Hash.from_xml(serialized_response)
        unmapped_responses = responses_hash['xml']['Response']
      end

      responses = []
      unmapped_responses.each do |response|
        r = Response.new
        r.id                        = response['ResponseID']
        r.response_set              = response['ResponseSet']
        r.ip_address                = response['IPAddress']
        r.start_date                = response['StartDate']
        r.end_date                  = response['EndDate']
        r.last_name                 = response['RecipientLastName']
        r.first_name                = response['RecipientFirstName']
        r.email                     = response['RecipientEmail']
        r.external_data_reference   = response['ExternalDataReference']
        r.finished                  = response['Finished']
        r.status                    = response['Status']
        r.location_latitude         = response['LocationLatitude']
        r.location_longitude        = response['LocationLongitude']
        r.location_accuracy         = response['LocationAccuracy']

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
