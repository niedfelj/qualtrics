# Qualtrics Ruby API Wrapper

| Master                                                                                                                                                                                                                                                                                          | Dev                                                                                                                                                                                                                                                                                 |
|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [![build status](https://code.osu.edu/asctech/qualtrics-ruby-api-wrapper/badges/master/build.svg)](https://code.osu.edu/asctech/qualtrics-ruby-api-wrapper/commits/master) [![coverage report](https://code.osu.edu/asctech/qualtrics-ruby-api-wrapper/badges/master/coverage.svg)](https://code.osu.edu/asctech/qualtrics-ruby-api-wrapper/commits/master) |  [![build status](https://code.osu.edu/asctech/qualtrics-ruby-api-wrapper/badges/dev/build.svg)](https://code.osu.edu/asctech/qualtrics-ruby-api-wrapper/commits/dev) [![coverage report](https://code.osu.edu/asctech/qualtrics-ruby-api-wrapper/badges/dev/coverage.svg)](https://code.osu.edu/asctech/qualtrics-ruby-api-wrapper/commits/dev) |


This is a wrapper for the [Qualtrics API](https://api.qualtrics.com) written in Ruby.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'qualtrics'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install qualtrics

## Usage

You will need to generate an API token in the Qualtrics IDs section of your Qualtrics account
settings.

Then to create a client instance:

```ruby
client = Qualtrics::API::Client.new(api_token: 'YOUR_TOKEN', data_center_id: 'YOUR_DATA_CENTER_ID')
```

## Design

This wrapper uses resources as ways of interacting with the endpoints of the Qualtrics API.
The resource action will then return a Ruby object. For surveys:

```ruby
client = Qualtrics::API::Client.new(api_token: 'YOUR_TOKEN', data_center_id: 'YOUR_DATA_CENTER_ID')
client.surveys.all
# => [ Qualtrics::API::Survey(id: '123', name: 'Your Survey',...) ]
# or individually...
client.surveys.find(id: '123')
# => Qualtrics::API::Survey(id: '123', name: 'Your Survey',...)
```

Creating and updating are done in a similar fashion:

```ruby
client = Qualtrics::API::Client.new(api_token: 'YOUR_TOKEN', data_center_id: 'YOUR_DATA_CENTER_ID')
user = Qualtrics::API::User.new(username: 'username', password: 'hunter2'...)
client.users.create(user)
# => Qualtrics::API::User(id: '123', username: 'username',...)
```

## All Resources and Actions

### Organizations Resource

```ruby
client = Qualtrics::API::Client.new(api_token: 'YOUR_TOKEN', data_center_id: 'YOUR_DATA_CENTER_ID')
client.organizations # => Qualtrics::API::OrganizationResource
```

#### Supported Actions

##### Find

`GET /API/v3/organizations/:id`

```ruby
client.organizations.find(id: '1234') # => Qualtrics::API::Organization
```

### Divisions Resource

##### Find

`GET /API/v3/divisions/:id`

```ruby
client.divisions.find(id: '1234') # => Qualtrics::API::Division
```

##### Create

`POST /API/v3/divisions`

```ruby
division = Division.new(name: 'division')
client.divisions.create(division) # => Qualtrics::API::Division
```

Required Attributes:

* name: `String` - Division name

Optional Attributes:

* division_admins :`Array` - Array of user IDs

##### Update

`PUT /API/v3/divisions/:id`

```ruby
division.name = 'New Name'
client.divisions.update(division, id: division.id) # => true
```

Optional Attributes:

* name: `String` - Division name
* status: `String` - New status of the division ('Active', 'Disabled')

### Groups Resource

```ruby
client = Qualtrics::API::Client.new(api_token: 'YOUR_TOKEN', data_center_id: 'YOUR_DATA_CENTER_ID')
client.groups # => Qualtrics::API::GroupResource
```

#### Supported Actions

##### All

`GET /API/v3/groups`

```ruby
client.groups.all # => [Qualtrics::API::Group]
```

##### Find

`GET /API/v3/groups/:id`

```ruby
client.groups.find(id: '1234') # => Qualtrics::API::Group
```

##### Create

`POST /API/v3/groups`

```ruby
group = Qualtrics::API::Group.new(type: '25241', name: 'my group')
client.groups.create(group) # => Qualtrics::API::Group
```

Required Attributes:

* type: `String` - Group type ID
* name: `String` - Name of the group

Optional Attributes:

* division_id: `String` - ID of the division to assign the group to

##### Update

`PUT /API/v3/groups/:id`

```ruby
group.type = '561614'
group.division_id = '12516'
client.groups.update(group, id: group.id) # => true
```

Optional Attributes:

* type: `String` - Group type ID
* name: `String` - Name of the group
* division_id: `String` - ID of the division to assign the group to

##### Delete

`DELETE /API/v3/groups/:id`

```ruby
client.groups.delete(id: 'w1551') # => true
```

##### Add User

`POST /API/v3/groups/:id/members`

```ruby
client.groups.add_user(id: '123123', user_id: '43672') # => true
```

##### Delete User

`DELETE /API/v3/groups/:id/members/:user_id`

```ruby
client.groups.delete_user(id: '1233412', user_id: '43426') # => true
```

### Users Resource

```ruby
client = Qualtrics::API::Client.new(api_token: 'YOUR_TOKEN', data_center_id: 'YOUR_DATA_CENTER_ID')
client.users # => Qualtrics::API::UserResource
```

#### Supported Actions

##### All

`GET /API/v3/users`

```ruby
client.users.all # => [Qualtrics::API::User]
```

##### Find

`GET /API/v3/users/:id`

```ruby
client.users.find(id: '623452') # => Qualtrics::API::User
```

##### Create

`POST /API/v3/users`

```ruby
user = Qualtrics::API::User.new(username: 'username', password: 'hunter2'...)
client.users.create(user) # => Qualtrics::API::User
```

Required Attributes:

* username: `String` - Unique Qualtrics username - must be valid email
* password: `String` - Password for new user
* first_name: `String` - Users first name
* last_name: `String` - Users last name
* user_type: `String` - User type for the user
* language: `String` - Language code for the new user - See [Qualtrics Language Codes](https://api.qualtrics.com/docs/language-codes)

Optional Attributes:

* division_id: `String` - ID of the division user will be assigned to
* account_expiration_date: `DateTime` - Date the new users account will expire

##### Update

`PUT /API/v3/users/:id`

```ruby
user.status = 'disabled'
client.users.update(user, id: user.id) # => true
```

Optional Attributes:

* username: `String` - Unique Qualtrics username - must be valid email
* password: `String` - Password for new user
* first_name: `String` - Users first name
* last_name: `String` - Users last name
* user_type: `String` - User type for the user
* language: `String` - Language code for the new user - See [Qualtrics Language Codes](https://api.qualtrics.com/docs/language-codes)
* division_id: `String` - ID of the division user will be assigned to
* account_expiration_date: `DateTime` - Date the new users account will expire
* status: `String` - Users account status (active, disabled, notVerified)

##### Delete

`DELETE /API/v3/users/:id`

```ruby
client.users.delete(id: '5135124') # => true
```

### Surveys Resource

```ruby
client = Qualtrics::API::Client.new(api_token: 'YOUR_TOKEN', data_center_id: 'YOUR_DATA_CENTER_ID')
client.surveys # => Qualtrics::API::SurveyResource
```

#### Supported Actions

##### All

`GET /API/v3/surveys`

```ruby
client.surveys.all # => [Qualtrics::API::Survey]
```

##### Find

`GET /API/v3/surveys/:id`

```ruby
client.surveys.find(id: '1231r5') # => Qualtrics::API::Survey
```

##### Update

`PUT /API/v3/surveys/:id`

```ruby
survey.name = 'New Survey Name'
client.surveys.update(survey, id: survey.id) # => true
```

Optional Attributes:

* name: `String` - Survey name
* is_active: `Boolean` - Survey active status
* expiration: `Hash` - Start and End dates for survey ({ start_date: Date.today, end_date: 2.weeks.from.now })

##### Delete

`DELETE /API/v3/surveys/:id`

```ruby
client.surveys.delete(id: '1641435') # => true
```

### Library Messages Resource

```ruby
client = Qualtrics::API::Client.new(api_token: 'YOUR_TOKEN', data_center_id: 'YOUR_DATA_CENTER_ID')
client.library_messages # => Qualtrics::API::LibraryMessageResource
```

#### Supported Actions

##### All

`GET /API/v3/libraries/:library_id/messages`

```ruby
client.library_messages.all(library_id: '151234') # => [Qualtrics::API::LibraryMessage]
```

##### Find

`GET /API/v3/libraries/:library_id/messages/:id`

```ruby
client.library_messages.find(library_id: '1251243', id: '452345') # => Qualtrics::API::LibraryMessage
```

##### Create

`POST /API/v3/libraries/:library_id/messages`

```ruby
library_message = Qualtrics::API::LibraryMessage.new(description: 'Description',...)
client.library_messages.create(library_message, library_id: '513223') # => Qualtrics::API::LibraryMessage
```

Required Attributes:

* description: `String` - Description for message
* messages: `Hash` - Messages mapped to language codes({ en: 'Message', "pt-br": "Mensagem" })
* category: `String` - Category in the following: invite, inactiveSurvey, reminder, thankYou, endOfSurvey, general, validation, lookAndFeel, emailSubject, smsInvite

##### Update

`PUT /API/v3/libraries/:library_id/messages/:id`

```ruby
library_message.messages = { 'en': 'New Message', 'es': 'Adding Spanish' }
client.library_messages.update(library_message, library_id: '23123', id: library_message.id) # => true
```

Optional Attributes:

* description: `String` - Description for message
* messages: `Hash` - Messages mapped to language codes({ en: 'Message', "pt-br": "Mensagem" })

##### Delete

`DELETE /API/v3/libraries/:library_id/messages/:id`

```ruby
client.library_messages.delete(library_id: '12321', id: '41231') # => true
```

### Distributions Resource

```ruby
client = Qualtrics::API::Client.new(api_token: 'YOUR_TOKEN', data_center_id: 'YOUR_DATA_CENTER_ID')
client.distributions # => Qualtrics::API::DistributionResource
```

#### Supported Actions

##### All

`GET /API/v3/distributions`

```ruby
client.distributions.all(survey_id: '123123') # => [Qualtrics::API::Distribution]
```

Optional Parameters:

* mailing_list_id: `String` - Mailing list or contact group associated with the distribution
* distribution_request_type: `String` - Specify the type of distribution (Invite, ThankYou, Reminder, Email, Portal, PortalInvite)
* send_start_date: `DateTime` - Starting range of the distribution send date
* send_end_date: `DateTime` - Ending range of the distribution send date

##### Find

`GET /API/v3/distributions/:id`

```ruby
client.distributions.find(id: '2341234', survey_id: '99391193') # => Qualtrics::API::Distribution
```

##### Create

`POST /API/v3/distributions`

```ruby
distribution_headers = Qualtrics::API::Distribution::Headers.new(from_email: 'email@email', from_name: 'Tom', reply_to_email: 'different@email', subject: 'Subject')
distribution_recipients = Qualtrics::API::Distribution::Recipients.new(mailing_list_id: '123123')
distribution = Qualtrics::API::Distribution.new(send_date: Date.today, headers: distribution_headers, recipients: distribution_recipients)
client.distributions.create(distribution) # => Qualtrics::API::Distribution
```

Required Attributes:

* send_date: `DateTime` - Time to send the email
* headers: `Qualtrics::API::Distribution::Headers` -
  * from_email: `String` - Email from address **(required)**
  * from_name: `String` - Email from name **(required)**
  * reply_to_email: `String` - Email reply to address **(required)**
  * subject: `String` - Email subject **(required)**
* recipients: `Qualtrics::API::Distribution::Recipients` -
  * mailing_list_id: `String` - ID of the mailing list **(required)**
  * contact_id: `String` - ID of a contact (optional)
* message: `Qualtrics::API::Distribution::Message` -
  * message_id: `String` - ID of the message (required along with library_id if message_text is not provided)
  * library_id: `String` - ID of the library (required along with message_id if message_text is not provided)
  * message_text: `String` - Custom message text (required if message_id and library_id are not provided)
* survey_link: `Qualtrics::API::Distribution::SurveyLink` -
  * survey_id: `String` - ID of the survey to send (required to send survey with distribution)
  * expiration_date: `DateTime` - Time of the expiry for the survey link (required to send survey with distribution)
  * type: `String` - Type of link to send out (Individual, Multiple, Anonymous) (required to send survey with distribution)

##### Create Thank You Distribution

`POST /API/v3/distribution/:id/thankyous`

```ruby
distribution_headers = Qualtrics::API::Distribution::Headers.new(from_email: 'email@email', from_name: 'Tom', subject: 'Subject')
distribution_message = Qualtrics::API::Distribution::Message.new(message_id: '123', library_id: '345')
thank_you_distribution = Qualtrics::API::Distribution.new(send_date: Date.today, headers: distribution_headers, message: distribution_message)
client.distributions.create_thankyou(thank_you_distribution, id: '3453')
```

Required Attributes:

* send_date: `DateTime` - Time to send the email
* headers: `Qualtrics::API::Distribution::Headers` -
  * from_email: `String` - Email from address **(required)**
  * from_name: `String` - Email from name **(required)**
  * reply_to_email: `String` - Email reply to address (optional)
  * subject: `String` - Email subject **(required)**
* message: `Qualtrics::API::Distribution::Message` -
  * message_id: `String` - ID of the message **(required)**
  * library_id: `String` - ID of the library **(required)**

##### Create Reminder Distribution

`POST /API/v3/distribution/:id/reminders`

```ruby
distribution_headers = Qualtrics::API::Distribution::Headers.new(from_email: 'email@email', from_name: 'Tom', subject: 'Subject')
distribution_message = Qualtrics::API::Distribution::Message.new(message_id: '123', library_id: '345')
reminder_distribution = Qualtrics::API::Distribution.new(send_date: Date.today, headers: distribution_headers, message: distribution_message)
client.distributions.create_reminder(reminder_distribution, id: '3453')
```

Required Attributes:

* send_date: `DateTime` - Time to send the email
* headers: `Qualtrics::API::Distribution::Headers` -
  * from_email: `String` - Email from address **(required)**
  * from_name: `String` - Email from name **(required)**
  * reply_to_email: `String` - Email reply to address (optional)
  * subject: `String` - Email subject **(required)**
* message: `Qualtrics::API::Distribution::Message` -
  * message_id: `String` - ID of the message **(required)**
  * library_id: `String` - ID of the library **(required)**

### Mailing List Resource

```ruby
client = Qualtrics::API::Client.new(api_token: 'YOUR_TOKEN', data_center_id: 'YOUR_DATA_CENTER_ID')
client.distributions # => Qualtrics::API::DistributionResource
```

#### Supported Actions

##### All

`GET /API/v3/mailinglists`

```ruby
client.mailing_lists.all # => [Qualtrics::API::MailingList]
```

##### Find

`GET /API/v3/mailinglists/:id`

```ruby
client.mailing_lists.find(id: '234234') # => Qualtrics::API::MailingList
```

##### Create

`POST /API/v3/mailinglists`

```ruby
mailing_list = Qualtrics::API::MailingList.new(library_id: '1231', name: 'name')
client.mailing_lists.create(mailing_list) # => Qualtrics::API::MailingList
```

Required Attributes:

* library_id: `String` - ID of the library
* name: `String` - Name of the mailing list

Optional Attributes:

* category: `String` - Category to create the mailing list in

##### Update

`PUT /API/v3/mailinglists/:id`

```ruby
maling_list.name = 'new name'
client.mailing_lists.update(mailing_list, id: mailing_list.id) # => true
```

Optional Attributes:

* library_id: `String` - ID of the library
* name: `String` - Name of the mailing list
* category: `String` - Category to create the mailing list in

##### Delete

`DELETE /API/v3/mailinglists/:id`

```ruby
client.mailing_lists.delete(id: '1231') # => true
```

##### List Contacts

`GET /API/v3/mailinglists/:id/contacts`

```ruby
client.mailing_lists.list_contacts(id: '123') # => [Qualtrics::API::MailingList::Contact]
```

##### Update Contact

`PUT /API/v3/mailinglists/:id/contacts/:contact_id`

```ruby
contact.first_name = 'New Name'
client.mailing_lists.update_contact(contact, id: '123', contact_id: contact.id) # => true
```

Optional Attributes:

* first_name: `String` - Contacts first name
* last_name: `String` - Contacts last name
* email: `String` - Contacts email
* external_data_reference: 'String' - External data reference
* language: `String` - Language code for the new user - See [Qualtrics Language Codes](https://api.qualtrics.com/docs/language-codes)
* unsubscribed: `Boolean` - Opt contact out of mailing list

##### Delete Contact

`DELETE /API/v3/mailinglists/:id/contacts/:contact_id`

```ruby
client.mailing_lists.delete_contact(id: '123', contact_id: '132') # => true
```

### Response Exports Resource

Response Exports are retrieved by a chain of API calls. The flow is:

`create export -> find export -> get export file -> unzip file -> map contents to response object`

Response Exports are sent in a .zip file and come in CSV, CSV 2013, XML, JSON, and SPSS formats (only JSON and XML are mappable to objects at this time).

#### Supported Actions

##### Create

`POST /API/v3/responseexports`

```ruby
client.response_exports.json(survey_id: '123', limit: 3) # => String (Response Export ID)
# or
client.response_exports.xml(survey_id: '123', use_labels: false) # => String (Response Export ID)
# or
client.response_exports.create(survey_id: '123', format: 'json') # => String (Response Export ID)
```

To create an export you can call create and pass the survey ID and format, or call the format method directly. Each of these will create a Response Export on Qualtrics' servers, the only value returned from the call is the ID of the export to be used in retrieval.

Optional Parameters:

* last_response_id: `String` - Export all responses received after a specific response
* start_date: `String` - Date range filter
* end_date: `String` - Date range filter
* limit: `Integer` - Max number of responses
* included_question_ids: `String` - Comma separated list of question ids to retrieve
* use_labels: `Booelan` - Export question labels instead of IDs
* decimal_separator: `String` - Decimal separator (comma, period)
* seen_unanswered_recode: `String` - Recode seen but unanswered questions with this value
* use_local_time: `Booelan` - Use local timezone for response date values

##### Find

`GET /API/responseexports/:id`

```ruby
client.response_exports.find(id: '123') # => Qualtrics::API::ResponseExport
```

##### Get File

`GET /API/responseexports/:id/file`

```ruby
client.response_exports.get_file(id: '123') # => Zip File
```

*Note: This is called from the find method, but it is callable on it's own if you need
just the file.*


