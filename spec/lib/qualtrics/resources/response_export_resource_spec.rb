require 'spec_helper'

RSpec.describe Qualtrics::ResponseExportResource do
  subject(:resource) { described_class.new(connection: connection) }
  include_context 'resources'

  describe '#find' do
    it 'returns the response export' do
      response = api_fixture('response_exports/find')
      stub_do_api('/API/v3/responseexports/123', :get).to_return(body: response)

      expected_record = Qualtrics::ResponseExportMapping.extract_single(response, :read)
      expect(resource.find(id: '123')).to eq expected_record
    end
  end

  describe '#create' do
    [:csv, :csv_2013, :xml, :json, :spss].each do |file_type|
      it "returns the response export id for file type: #{file_type}" do
        response = api_fixture('response_exports/create')
        stub_do_api('/API/v3/responseexports', :post).to_return(body: response)

        expect(resource.send(file_type, survey_id: '123')).to eq '123'
      end
    end
  end
end
