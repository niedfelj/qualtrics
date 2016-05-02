require 'spec_helper'

RSpec.describe Qualtrics::MailingListResource do
  subject(:resource) { described_class.new(connection: connection) }
  include_context 'resources'

  describe '#all' do
    it 'returns all of the mailing list records' do
      response = api_fixture('mailing_lists/all')
      normalized_response = JSON.parse(response)['result'].to_json
      stub_do_api('/API/v3/mailinglists', :get).to_return(body: response)

      expected_records = Qualtrics::MailingListMapping.extract_collection(normalized_response, :read)
      returned_records = resource.all

      expect(returned_records).to eq expected_records
    end
  end

  describe '#find' do
    it 'returns a mailing list' do
      response = api_fixture('mailing_lists/find')
      stub_do_api('/API/v3/mailinglists/123', :get).to_return(body: response)

      expected_record = Qualtrics::MailingListMapping.extract_single(response, :read)
      expect(resource.find(id: '123')).to eq expected_record
    end
  end

  describe '#create' do
    it 'returns the created mailing list with id' do
      response = api_fixture('mailing_lists/create')
      stub_do_api('/API/v3/mailinglists', :post).to_return(body: response)

      mailing_list = Qualtrics::MailingList.new
      expect(resource.create(mailing_list).id).to eq '123'
    end
  end

  describe '#update' do
    it 'sends the update request to the mailing list' do
      request = stub_do_api('/API/v3/mailinglists/123', :put)
      resource.update(Qualtrics::MailingList.new, id: '123')

      expect(request).to have_been_made
    end
  end

  describe '#delete' do
    it 'sends the delete request to the mailing list' do
      request = stub_do_api('/API/v3/mailinglists/123', :delete)
      resource.delete(id: '123')

      expect(request).to have_been_made
    end
  end

  describe '#list_contacts' do
    it 'returns all of the mailing lists contacts' do
      response = api_fixture('mailing_lists/list_contacts')
      normalized_response = JSON.parse(response)['result'].to_json
      stub_do_api('/API/v3/mailinglists/123/contacts', :get).to_return(body: response)

      expected_records = Qualtrics::ContactMapping.extract_collection(normalized_response, :read)
      returned_records = resource.list_contacts(id: '123')

      expect(returned_records).to eq expected_records
    end
  end

  describe '#update_contact' do
    it 'sends the update request to the contact' do
      request = stub_do_api('/API/v3/mailinglists/123/contacts/456', :put)
      resource.update_contact(Qualtrics::MailingList::Contact.new, id: '123', contact_id: '456')

      expect(request).to have_been_made
    end
  end

  describe '#delete_contact' do
    it 'sends the delete request for the contact' do
      request = stub_do_api('/API/v3/mailinglists/123/contacts/456', :delete)
      resource.delete_contact(Qualtrics::MailingList::Contact.new, id: '123', contact_id: '456')

      expect(request).to have_been_made
    end
  end
end
