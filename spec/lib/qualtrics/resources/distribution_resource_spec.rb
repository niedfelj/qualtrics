require 'spec_helper'

RSpec.describe Qualtrics::DistributionResource do
  subject(:resource) { described_class.new(connection: connection) }
  include_context 'resources'

  describe '#all' do
    it 'returns all of the user records' do
      response = api_fixture('distributions/all')
      normalized_response = JSON.parse(response)['result'].to_json
      stub_do_api('/API/v3/distributions', :get).to_return(body: response)

      expected_records = Qualtrics::DistributionMapping.extract_collection(normalized_response, :read)
      returned_records = resource.all

      expect(returned_records).to eq expected_records
    end
  end

  describe '#find' do
    it 'returns a distribution' do
      response = api_fixture('distributions/find')
      stub_do_api('/API/v3/distributions/123', :get).to_return(body: response)

      expected_record = Qualtrics::DistributionMapping.extract_single(response, :read)
      expect(resource.find(id: '123')).to eq expected_record
    end
  end

  describe '#create' do
    it 'returns created distribution with id' do
      response = api_fixture('distributions/create')
      stub_do_api('/API/v3/distributions', :post).to_return(body: response)

      expect(resource.create(Qualtrics::Distribution.new).id).to eq '123'
    end
  end

  describe '#create_thankyou' do
    it 'returns created thank you distributions with id' do
      response = api_fixture('distributions/thank_you')
      stub_do_api('/API/v3/distributions/789/thankyous').to_return(body: response)

      expect(resource.create_thankyou(Qualtrics::Distribution.new, id: '789').id).to eq '123'
    end
  end

  describe '#create_reminder' do
    it 'returns created reminder distribution with id' do
      response = api_fixture('distributions/reminder')
      stub_do_api('/API/v3/distributions/789/reminders').to_return(body: response)

      expect(resource.create_reminder(Qualtrics::Distribution.new, id: '789').id).to eq '123'
    end
  end
end
