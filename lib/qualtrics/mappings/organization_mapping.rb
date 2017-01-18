module Qualtrics::API
  class OrganizationMapping
    include Kartograph::DSL

    kartograph do
      mapping Organization
      root_key singular: "result", scopes: [:read]

      scoped :read do
        property :id
        property :name
        property :base_url
        property :type
        property :status
        property :stats
      end
    end
  end
end
