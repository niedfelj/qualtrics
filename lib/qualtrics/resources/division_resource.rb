module Qualtrics
  class DivisionResource < ResourceKit::Resource
    include ErrorHandlingResourceable

    resources do
      action :find, 'GET /API/v3/divisions/:id' do
        handler(200) { |response| DivisionMapping.extract_single(response.body, :read) }
      end

      action :create, 'POST /API/v3/divisions' do
        body { |object| DivisionMapping.representation_for(:create, object) }
        handler(200) do |response, object|
          object.id = JSON.parse(response.body)['result']['id']
          object
        end
      end

      action :update, 'PUT /API/v3/divisions/:id' do
        body { |object| DivisionMapping.representation_for(:update, object) }
        handler(200) { |_| true }
      end
    end
  end
end
