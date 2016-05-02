module Qualtrics
  class MailingListMapping
    include Kartograph::DSL

    kartograph do
      mapping MailingList
      root_key singular: 'result', plural: 'elements', scopes: [:read]

      property :id,         scopes: [:read]
      property :name,       scopes: [:read, :create]
      property :library_id, scopes: [:read, :create], key: 'libraryId'
      property :category,   scopes: [:read, :create, :update], optional: true

      scoped :update do
        property :name, optional: true
        property :library_id, key: 'libraryId', optional: true
      end
    end
  end
end
