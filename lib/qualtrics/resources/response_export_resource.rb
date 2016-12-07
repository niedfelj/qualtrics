module Qualtrics::API
  class ResponseExportResource < ResourceKit::Resource
    include ErrorHandlingResourceable

    [:csv, :csv_2013, :xml, :json, :spss].each do |file_type|
      define_method file_type do |opts|
        opts[:file_type] = file_type
        create(opts)
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
        body do |hash|
          params = { surveyId: hash[:survey_id], format: hash[:file_type] }
          optional_params = [:last_response_id, :start_date, :end_date, :limit,
                             :included_question_ids, :use_label, :decimal_separator,
                             :seen_unanswered_record, :use_local_time]

          optional_params.each do |optional_param|
            key = optional_param.to_s.camelize(:lower).to_sym
            params[key] = hash[optional_param] if hash.has_key?(optional_param)
          end

          params.to_json
        end

        handler(200) { |response| JSON.parse(response.body)['result']['id'] }
      end

      action :get_file, 'GET /API/v3/responseexports/:id/file' do
        handler(200) { |response| response.body }
      end
    end
  end
end
