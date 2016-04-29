module Qualtrics
  class UserMapping
    include Kartograph::DSL

    kartograph do
      mapping User
      root_key singular: 'result', plural: 'elements', scopes: [:read]

      property :username,     scopes: [:read, :create, :update]
      property :first_name,   scopes: [:read, :create, :update],   key: 'firstName'
      property :last_name,    scopes: [:read, :create, :update],   key: 'lastName'
      property :user_type,    scopes: [:read, :create, :update],   key: 'userType'
      property :language,     scopes: [:read, :create, :update]
      property :status,       scopes: [:read, :update]
      # property :permissions,  scopes: [:read, :update]

      scoped :read do
        property :id
        property :organization_id,            key: 'organizationId'
        property :division_id,                key: 'divisionId'
        property :unsubscribed
        property :account_creation_date,      key: 'accountCreationDate'
        property :account_expiration_date,    key: 'accountExpirationDate'
        property :password_last_changed_date, key: 'passwordLastChangedDate'
        property :password_expiration_date,   key: 'passwordExpirationDate'
        property :last_login_date,            key: 'lastLoginDate'
        property :response_counts,            key: 'responseCounts'
      end

      scoped :create do
        property :password,     scopes: [:create]
        property :email,        scopes: [:create]
      end

      scoped :create, :update do
        property :division_id,  key: 'divisionId', optional: true
      end
    end
  end
end
