require 'pry'
require 'json'

module ErrorHandlingResourceable
  def self.included(base)
    base.send(:resources) do
      default_handler do |response|
        if (200...299).include?(response.status)
          next
        elsif response.status == 429
          error = Qualtrics::RateLimitReached.new("#{response.status}: #{response.body}")
          error.limit = response.headers['RateLimit-Limit']
          error.remaining = response.headers['RateLimit-Remaining']
          error.reset_at = response.headers['RateLimit-Reset']
          raise error
        else
          body = JSON.parse(response.body)
          error_message = body['meta']['error']['errorMessage']
          error_code = body['meta']['error']['errorCode']
          raise Qualtrics::Error.new("Status: #{response.status} Error: #{error_code} - #{error_message}")
        end
      end
    end
  end
end
