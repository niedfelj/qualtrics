require 'spec_helper'

RSpec.describe Qualtrics::ResponseExport do
  describe '#get_responses' do
    context 'json' do
      it 'returns an array of responses' do
        file_response = file_response_fixture('response_exports/json_export')

        response_export = Qualtrics::ResponseExport.new(id: '123', percent_complete: 100, file: file_response)
        responses = response_export.get_responses

        expect(responses.map(&:class)).to include Qualtrics::Response
      end
    end

    context 'xml' do
      it 'returns an array of responses' do
        file_response = file_response_fixture('response_exports/xml_export')

        response_export = Qualtrics::ResponseExport.new(id: '123', percent_complete: 100, file: file_response)
        responses = response_export.get_responses

        expect(responses.map(&:class)).to include Qualtrics::Response
      end
    end
  end
end
