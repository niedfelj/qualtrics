require 'spec_helper'

RSpec.describe Qualtrics::ResponseImportResource do
  subject(:resource) { described_class.new(connection: connection) }
  include_context 'resources'

  describe '#import' do
    it 'returns the id of the imported responses' do
      response = api_fixture('response_imports/import')
      allow(Faraday::UploadIO).to receive(:new) { '/file_path' }
      stub_do_api('/API/v3/responseimports', :post).to_return(body: response)

      expect(resource.import(survey_id: '456', file_path: '/path/to/csv')). to eq '123'
    end
  end

  describe '#import_from_url' do
    it 'returns the id of the imported responses' do
      response = api_fixture('response_imports/import')
      stub_do_api('/API/v3/responseimports', :post).to_return(body: response)

      expect(resource.import_from_url(survey_id: '456', file_url: 'https://url.com')).to eq '123'
    end
  end

  describe '#find' do
    it 'returns the completion percentage of the response import' do
      response = api_fixture('response_imports/find')
      stub_do_api('/API/v3/responseimports/123', :get).to_return(body: response)

      expect(resource.find(id: '123')).to eq 100
    end
  end
end
