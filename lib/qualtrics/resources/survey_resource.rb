module Qualtrics::API
  class SurveyResource < ResourceKit::Resource
    include ErrorHandlingResourceable

    resources do
      action :all, "GET /API/v3/surveys" do
        query_keys :offset 
        handler(200) do |response|
          body = JSON.parse(response.body)["result"].to_json
          SurveyMapping.extract_collection(body, :read)
        end
      end

      action :find, "GET /API/v3/surveys/:id" do
        handler(200) { |response| SurveyMapping.extract_single(response.body, :read) }
      end

      action :update, "PUT /API/v3/surveys/:id" do
        body { |object| SurveyMapping.representation_for(:update, object) }
        handler(200) { |_| true }
      end

      action :delete, "DELETE /API/v3/surveys/:id" do
        handler(200) { |_| true }
      end
    end
  end
end
