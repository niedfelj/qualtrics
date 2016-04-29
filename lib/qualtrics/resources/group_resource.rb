module Qualtrics
  class GroupResource < ResourceKit::Resource
    include ErrorHandlingResourceable

    resources do
      action :all, 'GET /API/v3/groups' do
        handler(200) do |response|
          body = JSON.parse(response.body)['result'].to_json
          GroupMapping.extract_collection(body, :read)
        end
      end

      action :find, 'GET /API/v3/groups/:id' do
        handler(200) { |response| GroupMapping.extract_single(response.body, :read) }
      end

      action :create, 'POST /API/v3/groups' do
        body { |object| GroupMapping.representation_for(object, :create) }
        handler(200) do |response, object|
          object.id = JSON.parse(response.body)['result']['groupId']
          object
        end
      end

      action :update, 'PUT /API/v3/groups/:id' do
        body { |object| GroupMapping.representation_for(object, :update) }
        handler(200) { |_| true }
      end

      action :delete, 'DELETE /API/v3/groups/:id' do
        handler(200) { |_| true }
      end

      action :add_user, 'POST /API/v3/groups/:id/members' do
        body { |user_id| { userId: user_id }.to_json }
        handler(200) { |_| true }
      end

      action :delete_user, 'DELETE /API/v3/groups/:id/members/:user_id' do
        handler(200) { |_| true }
      end
    end
  end
end
