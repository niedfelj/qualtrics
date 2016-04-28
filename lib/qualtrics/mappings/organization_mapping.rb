module Qualtrics
  class OrganizationMapping
    include Kartograph::DSL

    kartograph do
      root_key singular: 'result', scopes: [:read]
      mapping Organization

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
