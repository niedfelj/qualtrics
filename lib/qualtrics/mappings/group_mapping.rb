module Qualtrics
  class GroupMapping
    include Kartograph::DSL

    kartograph do
      mapping Group
      root_key singular: 'result', plural: 'elements', scopes: [:read]

      property :type, scopes: [:read, :create]
      property :name, scopes: [:read, :create]
      property :division_id, scopes: [:read, :update], key: 'divisionId', optional: true

      scoped :read do
        property :id
        property :organization_id,  key: 'organizationId'
        property :all_users,        key: 'allUsers'
        property :creation_date,    key: 'creationDate'
        property :creator_id,       key: 'creatorId'
      end

      scoped :update do
        property :type, optional: true
        property :name, optional: true
      end
    end
  end
end
