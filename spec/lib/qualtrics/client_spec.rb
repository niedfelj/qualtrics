require 'spec_helper'

RSpec.describe Qualtrics::Client do
  subject(:client) { Qualtrics::Client.new(api_token: 'not real', data_center_id: 'org') }

  describe '#initialize' do
    it 'initializes with an access token' do
      expect(client.api_token).to eq 'not real'
    end

    it 'initializes with a data center id' do
      expect(client.data_center_id).to eq 'org'
    end
  end

  describe '#method_missing' do
    context 'called with an existing method' do
      it { expect{ client.surveys }.not_to raise_error }
    end

    context 'called with a missing method' do
      it { expect{ client.not_a_method }.to raise_error(NoMethodError) }
    end
  end

  describe '#connection' do
    it 'populates the x-api-token correctly' do
      expect(client.connection.headers['X-Api-Token']).to eq ('not real')
    end

    it 'sets the content type' do
      expect(client.connection.headers['Content-Type']).to eq 'application/json'
    end
  end
end
