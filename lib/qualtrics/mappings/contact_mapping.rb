module Qualtrics::API
  class ContactMapping
    include Kartograph::DSL

    kartograph do
      mapping MailingList::Contact
      root_key plural: "elements", scopes: [:read]

      property :id, scopes: [:read]

      scoped :read, :update do
        property :first_name,               key: "firstName",             optional: true
        property :last_name,                key: "lastName",              optional: true
        property :email,                                                  optional: true
        property :external_data_reference,  key: "externalDataReference", optional: true
        property :language,                                               optional: true
        property :embedded_data,            key: "embeddedData",          optional: true
        property :unsubscribed,                                           optional: true
      end
    end
  end
end
