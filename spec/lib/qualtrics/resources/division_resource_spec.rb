require 'spec_helper'

RSpec.describe Qualtrics::API::DivisionResource do
  subject(:resource) { described_class.new(connection: connection) }
  include_context 'resources'

  describe '#find' do
    it 'returns a division' do
      response = api_fixture('divisions/find')
      stub_do_api('/API/v3/divisions/123', :get).to_return(body: response)

      expected_record = Qualtrics::API::DivisionMapping.extract_single(response, :read)
      expect(resource.find(id: '123')).to eq expected_record
    end
  end

  describe '#create' do
    it 'returns created division with id' do
      response = api_fixture('divisions/create')
      stub_do_api('/API/v3/divisions', :post).to_return(body: response)

      expect(resource.create(Qualtrics::API::Division.new).id).to eq '123'
    end
  end

  describe '#update' do
    it 'sends the udpate request for the division' do
      request = stub_do_api('/API/v3/divisions/123', :put)
      resource.update(Qualtrics::API::Division.new, id: '123')

      expect(request).to have_been_made
    end
  end
end
