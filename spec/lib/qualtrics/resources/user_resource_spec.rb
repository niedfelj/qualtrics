require 'spec_helper'

RSpec.describe Qualtrics::UserResource do
  subject(:resource) { described_class.new(connection: connection) }
  include_context 'resources'

  describe '#all' do
    it 'returns all of the user records' do
      response = api_fixture('users/all')
      normalized_response = JSON.parse(response)['result'].to_json
      stub_do_api('/API/v3/users', :get).to_return(body: response)

      expected_records = Qualtrics::UserMapping.extract_collection(normalized_response, :read)
      returned_records = resource.all

      expect(returned_records).to eq expected_records
    end
  end

  describe '#find' do
    it 'returns a user' do
      response = api_fixture('users/find')
      stub_do_api('/API/v3/users/12345', :get).to_return(body: response)

      expected_record = Qualtrics::UserMapping.extract_single(response, :read)
      expect(resource.find(id: '12345')).to eq expected_record
    end
  end

  describe '#create' do
    it 'returns created user with id' do
      response = api_fixture('users/create')
      stub_do_api('/API/v3/users', :post).to_return(body: response)

      user = Qualtrics::User.new(username: 'name')
      expect(resource.create(user).id).to eq '12345'
    end
  end

  describe '#update' do
    it 'sends the update request for the user' do
      request = stub_do_api('/API/v3/users/123', :put)
      resource.update(Qualtrics::User.new, id: '123')

      expect(request).to have_been_made
    end
  end

  describe '#delete' do
    it 'sends the delete request for the user' do
      request = stub_do_api('/API/v3/users/123', :delete)
      resource.delete(id: '123')

      expect(request).to have_been_made
    end
  end
end
