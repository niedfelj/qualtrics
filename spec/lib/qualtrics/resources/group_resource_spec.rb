require 'spec_helper'

RSpec.describe Qualtrics::API::GroupResource do
  subject(:resource) { described_class.new(connection: connection) }
  include_context 'resources'

  describe '#all' do
    it 'returns all the of group records' do
      response = api_fixture('groups/all')
      normalized_response = JSON.parse(response)['result'].to_json
      stub_do_api('/API/v3/groups', :get).to_return(body: response)

      expected_records = Qualtrics::API::GroupMapping.extract_collection(normalized_response, :read)
      returned_records = resource.all

      expect(returned_records).to eq expected_records
    end
  end

  describe '#find' do
    it 'returns a group' do
      response = api_fixture('groups/find')
      stub_do_api('/API/v3/groups/123', :get).to_return(body: response)

      expected_record = Qualtrics::API::GroupMapping.extract_single(response, :read)
      expect(resource.find(id: '123')).to eq expected_record
    end
  end

  describe '#create' do
    it 'returns created group with id' do
      response = api_fixture('groups/create')
      stub_do_api('/API/v3/groups', :post).to_return(body: response)

      expect(resource.create(Qualtrics::API::Group.new).id).to eq '123'
    end
  end

  describe '#update' do
    it 'sends the update request for the group' do
      request = stub_do_api('/API/v3/groups/123', :put)
      resource.update(Qualtrics::API::Group.new, id: '123')

      expect(request).to have_been_made
    end
  end

  describe '#delete' do
    it 'sends the delete request for the group' do
      request = stub_do_api('/API/v3/groups/123', :delete)
      resource.delete(id: '123')

      expect(request).to have_been_made
    end
  end

  describe '#add_user' do
    it 'sends the add user request for the group' do
      request = stub_do_api('/API/v3/groups/123/members', :post)
      resource.add_user(id: '123', user_id: '456')

      expect(request).to have_been_made
    end
  end

  describe '#delete_user' do
    it 'sends the delete user request for the group' do
      request = stub_do_api('/API/v3/groups/123/members/456', :delete)
      resource.delete_user(id: '123', user_id: '456')

      expect(request).to have_been_made
    end
  end
end
