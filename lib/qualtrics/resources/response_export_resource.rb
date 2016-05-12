module Qualtrics
  class ResponseExportResource < ResourceKit::Resource
    include ErrorHandlingResourceable

    [:csv, :csv_2013, :xml, :json, :spss].each do |file_type|
      define_method file_type do |survey_id|
        create(survey_id: survey_id, file_type: file_type)
      end
    end

    resources do
      action :find, 'GET /API/v3/responseexports/:id' do
        handler(200) do |response, hash|
          resp_exp = ResponseExportMapping.extract_single(response.body, :read)
          resp_exp.id = hash[:id]

          unless resp_exp.percent_complete < 100
            resp_exp.file = get_file(id: hash[:id])
          end

          resp_exp
        end
      end

      action :create, 'POST /API/v3/responseexports' do
        body { |hash| { surveyId: hash[:survey_id], format: hash[:file_type] }.to_json }
        handler(200) { |response| JSON.parse(response.body)['result']['id'] }
      end

      action :get_file, 'GET /API/v3/responseexports/:id/file' do
        handler(200) { |response| response.body }
      end
    end
  end
end
