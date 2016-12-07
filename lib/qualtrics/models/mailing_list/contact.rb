module Qualtrics::API
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

    ##
    # Make the model serializeable by ActiveModelSerializer
    #
    # @return [OpenStruct]
    #
    def self.model_name
      OpenStruct.new(name: "Qualtrics::API::MailingList::Contact",
                     klass: self,
                     singular: "qualtrics_mailing_list_contact",
                     plural: "qualtrics_mailing_list_contacts",
                     element: "mailing_list_contacts",
                     human: "mailing_list_contact",
                     collection: "qualtrics/mailing_list_contacts",
                     param_key: "qualtrics_mailing_list_contacts",
                     i18n_key: "qualtrics/mailing_list_contacts",
                     route_key: "qualtrics_mailing_list_contacts",
                     singular_route_key: "qualtrics_mailing_list_contact")
    end
  end
end
