module Qualtrics
  class MailingList::Contact < BaseModel
    attribute :id
    attribute :first_name
    attribute :last_name
    attribute :email
    attribute :external_data_reference
    attribute :embedded_data
    attribute :language
    attribute :unsubscribed
    attribute :response_history
    attribute :email_history
  end
end
