module Qualtrics
  class ResponseImportResource < ResourceKit::Resource
    include ErrorHandlingResourceable

    resources do
      action :import, 'POST /API/v3/responseimports' do
        body do |survey_id, file_path|
          {
            surveyId: survey_id,
            file: Faraday::UploadIO.new(file_path, 'application/csv')
          }
        end
        handler(200) { |response| JSON.parse(response.body)['result']['id'] }
      end

      action :import_from_url, 'POST /API/v3/responseimports' do
        body { |survey_id, file_url| { surveyId: survey_id, fileUrl: file_url, contentType: 'application/csv'} }
        handler(200) { |response| JSON.parse(response.body)['result']['id'] }
      end

      action :find, 'GET /API/v3/responseimports/:id' do
        handler(200) { |response| JSON.parse(response.body)['result']['percentComplete'] }
      end
    end
  end
end
