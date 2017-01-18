module Qualtrics::API
  class DistributionResource < ResourceKit::Resource
    include ErrorHandlingResourceable

    resources do
      action :all, "GET /API/v3/distributions" do
        query_keys surveyId: :survey_id, mailingListId: :mailing_list_id,
                   distributionRequestType: :distribution_request_type,
                   sendStartDate: :send_start_date, sendEndDate: :send_end_date

        handler(200) do |response|
          response_body = JSON.parse(response.body)["result"].to_json
          DistributionMapping.extract_collection(response_body, :read)
        end
      end

      action :find, "GET /API/v3/distributions/:id" do
        query_keys surveyId: :survey_id
        handler(200) { |response| DistributionMapping.extract_single(response.body, :read) }
      end

      action :create, "POST /API/v3/distributions" do
        body { |object| DistributionMapping.representation_for(:create, object) }
        handler(200) do |response, object|
          object.id = JSON.parse(response.body)["result"]["id"]
          object
        end
      end

      action :create_thankyou, "POST /API/v3/distributions/:id/thankyous" do
        body { |object| DistributionMapping.representation_for(:create_child, object) }
        handler(200) do |response, object|
          object.id = JSON.parse(response.body)["result"]["distributionId"]
          object
        end
      end

      action :create_reminder, "POST /API/v3/distributions/:id/reminders" do
        body { |object| DistributionMapping.representation_for(:create_child, object) }
        handler(200) do |response, object|
          object.id = JSON.parse(response.body)["result"]["distributionId"]
          object
        end
      end
    end
  end
end
