module Qualtrics
  class DivisionMapping
    include Kartograph::DSL

    kartograph do
      mapping Division
      root_key singular: 'result', scopes: [:read]

      property :name,   scopes: [:read, :update], optional: true
      property :status, scopes: [:read, :update], optional: true
      # property :permissions, scopes: [:read, :create, :update], optional: true

      scoped :read do
        property :id
        property :organization_id,  key: 'organizationId'
        property :creation_date,    key: 'creationDate'
        property :creator_id,       key: 'creatorId'
        property :response_counts,  key: 'responseCounts'
      end

      scoped :create do
        property :name
        property :division_admins, key: 'divisionAdmins', optional: true
      end
    end
  end
end
