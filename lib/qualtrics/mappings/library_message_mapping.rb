module Qualtrics::API
  class LibraryMessageMapping
    include Kartograph::DSL

    kartograph do
      mapping LibraryMessage
      root_key singular: 'result', plural: 'elements', scopes: [:read]

      property :id,           scopes: [:read]
      property :category,     scopes: [:read, :create]
      property :messages,     scopes: [:read, :update], optional: true
      property :description,  scopes: [:read, :update], optional: true

      scoped :create do
        property :description
        property :messages
      end
    end
  end
end
