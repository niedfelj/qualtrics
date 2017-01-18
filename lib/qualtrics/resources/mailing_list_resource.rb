module Qualtrics::API
  class MailingListResource < ResourceKit::Resource
    include ErrorHandlingResourceable

    resources do
      action :all, "GET /API/v3/mailinglists" do
        handler(200) do |response|
          body = JSON.parse(response.body)["result"].to_json
          MailingListMapping.extract_collection(body, :read)
        end
      end

      action :find, "GET /API/v3/mailinglists/:id" do
        handler(200) { |response| MailingListMapping.extract_single(response.body, :read) }
      end

      action :create, "POST /API/v3/mailinglists" do
        body { |object| MailingListMapping.representation_for(:create, object) }
        handler(200) do |response, object|
          object.id = JSON.parse(response.body)["result"]["id"]
          object
        end
      end

      action :update, "PUT /API/v3/mailinglists/:id" do
        body { |object| MailingListMapping.representation_for(:update, object) }
        handler(200) { |_| true }
      end

      action :delete, "DELETE /API/v3/mailinglists/:id" do
        handler(200) { |_| true }
      end

      action :list_contacts, "GET /API/v3/mailinglists/:id/contacts" do
        handler(200) do |response|
          body = JSON.parse(response.body)["result"].to_json
          ContactMapping.extract_collection(body, :read)
        end
      end

      action :update_contact, "PUT /API/v3/mailinglists/:id/contacts/:contact_id" do
        body { |object| ContactMapping.representation_for(:update, object) }
        handler(200) { |_| true }
      end

      action :delete_contact, "DELETE /API/v3/mailinglists/:id/contacts/:contact_id" do
        handler(200) { |_| true }
      end
    end
  end
end
