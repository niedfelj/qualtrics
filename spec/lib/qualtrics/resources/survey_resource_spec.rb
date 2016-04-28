require 'spec_helper'

RSpec.describe Qualtrics::SurveyResource do
  subject(:resource) { described_class.new(connection: connection) }
  include_context 'resources'

  describe '#all' do
    it 'returns all the of survey records' do
      response = api_fixture('surveys/all')
      normalized_response = JSON.parse(response)['result'].to_json
      stub_do_api('/API/v3/surveys', :get).to_return(body: response)

      expected_records = Qualtrics::SurveyMapping.extract_collection(normalized_response, :read)
      returned_records = resource.all

      expect(returned_records).to eq expected_records
    end
  end

  describe '#find' do
    it 'returns a survey' do
      response = api_fixture('surveys/find')
      stub_do_api('/API/v3/surveys/123', :get).to_return(body: response)

      expected_record = Qualtrics::SurveyMapping.extract_single(response, :read)
      expect(resource.find(id: '123')).to eq expected_record
    end
  end

  describe '#update' do
    it 'returns the updated survey' do
      survey = JSON.parse api_fixture('surveys/find')
      survey['result']['id'] = '123'
      survey['result']['name'] = 'New Name'
      response = survey.to_json
      stub_do_api('/API/v3/surveys/123', :put).to_return(body: nil)
      stub_do_api('/API/v3/surveys/123', :get).to_return(body: response)

      expected_record = Qualtrics::SurveyMapping.extract_single(response, :read)
      expect(resource.update(expected_record, id: '123')).to eq expected_record
    end
  end

  describe '#delete' do
    it 'sends a delete request for the survey' do
      request = stub_do_api('/API/v3/surveys/123', :delete)
      resource.delete(id: '123')

      expect(request).to have_been_made
    end
  end
end
