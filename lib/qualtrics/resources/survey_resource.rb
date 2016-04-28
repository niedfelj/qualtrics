require 'json'

module Qualtrics
  class SurveyResource < ResourceKit::Resource
    resources do
      action :all do
        path '/API/v3/surveys'
        handler(200) do |response|
          resp = JSON.parse response.body
          SurveyMapping.extract_collection(resp['result'].to_json, :read)
        end
      end

      action :find do
        path '/API/v3/surveys/:id'
        handler(200) { |response| SurveyMapping.extract_single(response.body, :read) }
      end
    end
  end
end
