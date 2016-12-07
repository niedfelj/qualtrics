require 'spec_helper'

RSpec.describe Qualtrics::API::LibraryMessageResource do
  subject(:resource) { described_class.new(connection: connection) }
  include_context 'resources'

  describe '#all' do
    it 'returns all the of messages in library' do
      response = api_fixture('library_messages/all')
      normalized_response = JSON.parse(response)['result'].to_json
      stub_do_api('/API/v3/libraries/789/messages', :get).to_return(body: response)

      expected_records = Qualtrics::API::LibraryMessageMapping.extract_collection(normalized_response, :read)
      returned_records = resource.all(library_id: '789')

      expect(returned_records).to eq expected_records
    end
  end

  describe '#find' do
    it 'returns a library message' do
      response = api_fixture('library_messages/find')
      stub_do_api('/API/v3/libraries/789/messages/123', :get).to_return(body: response)

      expected_record = Qualtrics::API::LibraryMessageMapping.extract_single(response, :read)
      expected_record.id = '123'
      expect(resource.find(id: '123', library_id: '789')).to eq expected_record
    end
  end

  describe '#create' do
    it 'returns created message with id' do
      response = api_fixture('library_messages/create')
      stub_do_api('/API/v3/libraries/789/messages', :post).to_return(body: response)

      library_message = Qualtrics::API::LibraryMessage.new
      expect(resource.create(library_message, library_id: '789').id).to eq '123'
    end
  end

  describe '#update' do
    it 'sends the update request for the library message' do
      request = stub_do_api('/API/v3/libraries/789/messages/123', :put)
      library_message = Qualtrics::API::LibraryMessage.new
      resource.update(library_message, id: '123', library_id: '789')

      expect(request).to have_been_made
    end
  end

  describe '#delete' do
    it 'sends the delete request for the library message' do
      request = stub_do_api('/API/v3/libraries/789/messages/123', :delete)
      resource.delete(id: '123', library_id: '789')

      expect(request).to have_been_made
    end
  end
end
