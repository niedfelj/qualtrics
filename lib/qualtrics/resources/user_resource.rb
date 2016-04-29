require 'json'

module Qualtrics
  class UserResource < ResourceKit::Resource
    include ErrorHandlingResourceable

    resources do
      action :all, 'GET /API/v3/users' do
        handler(200) do |response|
          body = JSON.parse(response.body)['result'].to_json
          UserMapping.extract_collection(body, :read)
        end
      end

      action :find, 'GET /API/v3/users/:id' do
        handler(200) { |response| UserMapping.extract_single(response.body, :read) }
      end

      action :create, 'POST /API/v3/users' do
        body { |object| UserMapping.representation_for(:create, object) }
        handler(200) do |response, object|
          id = JSON.parse(response.body)['result']['id']
          object.id = id
          object
        end
      end

      action :update, 'PUT /API/v3/users/:id' do
        body { |object| UserMapping.representation_for(:update, object) }
        handler(200) { |_| true }
      end

      action :delete, 'DELETE /API/v3/users/:id' do
        handler(200) { |_| true }
      end
    end
  end
end
