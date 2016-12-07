module Qualtrics::API
  class LibraryMessageResource < ResourceKit::Resource
    include ErrorHandlingResourceable

    resources do
      action :all, 'GET /API/v3/libraries/:library_id/messages' do
        handler(200) do |response|
          body = JSON.parse(response.body)['result'].to_json
          LibraryMessageMapping.extract_collection(body, :read)
        end
      end

      action :find, 'GET /API/v3/libraries/:library_id/messages/:id' do
        # Qualtrics doesn't return the id in the response
        # so we have to assign it from the passed message_id
        handler(200) do |response, id|
          lib_msg = LibraryMessageMapping.extract_single(response.body, :read)
          lib_msg.id = id
          lib_msg
        end
      end

      action :create, 'POST /API/v3/libraries/:library_id/messages' do
        body { |object| LibraryMessageMapping.representation_for(:create, object) }
        handler(200) do |response, object|
          object.id = JSON.parse(response.body)['result']['id']
          object
        end
      end

      action :update, 'PUT /API/v3/libraries/:library_id/messages/:id' do
        body { |object| LibraryMessageMapping.representation_for(:update, object) }
        handler(200) { |_| true }
      end

      action :delete, 'DELETE /API/v3/libraries/:library_id/messages/:id' do
        handler(200) { |_| true }
      end
    end
  end
end
