module Qualtrics
  class OrganizationResource < ResourceKit::Resource
    include ErrorHandlingResourceable

    resources do
      action :find do
        path '/API/v3/organizations/:id'
        handler(200) { |response| OrganizationMapping.extract_single(response.body, :read) }
      end
    end
  end
end
