module Qualtrics
  class DistributionMapping
    include Kartograph::DSL

    kartograph do
      mapping Distribution
      root_key singular: 'result', plural: 'elements', scopes: [:read]

      property :send_date, scopes: [:read, :create, :create_child],  key: 'sendDate'

      property :recipients, scopes: [:read, :create] do
        mapping Distribution::Recipients

        property :mailing_list_id,  scopes: [:read, :create], key: 'mailingListId'
        property :contact_id,       scopes: [:read, :create], key: 'contactId', optional: true
      end

      property :headers, scopes: [:read, :create, :create_child] do
        mapping Distribution::Headers

        property :from_email,     scopes: [:read, :create, :create_child], key: 'fromEmail'
        property :from_name,      scopes: [:read, :create, :create_child], key: 'fromName'
        property :reply_to_email, scopes: [:read, :create, :create_child], key: 'replyToEmail'
        property :subject,        scopes: [:read, :create, :create_child]
      end

      property :message, scopes: [:read, :create], optional: true do
        mapping Distribution::Message

        property :message_id,   scopes: [:read, :create], key: 'messageId'
        property :library_id,   scopes: [:read, :create], key: 'libraryId'
        property :message_text, scopes: [:read, :create], key: 'messageText'
      end

      property :survey_link, scopes: [:read, :create], optional: true do
        mapping Distribution::SurveyLink

        property :survey_id,        scopes: [:read, :create], key: 'surveyId'
        property :expiration_date,  scopes: [:read, :create], key: 'expirationDate'
        property :type,             scopes: [:read, :create]
      end

      scoped :read do
        property :id
        property :parent_distribution_id, key: 'parentDistributionId'
        property :owner_id,               key: 'ownerId'
        property :organization_id,        key: 'organizationId'
        property :request_status,         key: 'requestStatus'
        property :request_type,           key: 'requestType'
        property :created_date,           key: 'createdDate'
        property :modified_date,          key: 'modifiedDate'
        property :stats
      end

      scoped :create_child do
        property :message do
          mapping Distribution::Message

          scoped :create_child do
            property :message_id, key: 'messageId'
            property :library_id, key: 'libraryId'
            property :message_text, key: 'messageText'
          end
        end
      end
    end
  end
end
