module Qualtrics
  class SurveyMapping
    include Kartograph::DSL

    kartograph do
      mapping Survey
      root_key singular: 'result', plural: 'elements', scopes: [:read]

      scoped :read do
        property :id
        property :name
        property :owner_id, key: 'ownerId'
        property :last_modified, key: 'lastModified'
        property :is_active, key: 'isActive'
        property :organization_id, key: 'organizationId'
      end
    end
  end
end
