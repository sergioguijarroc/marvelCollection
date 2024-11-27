require 'digest/md5'
require 'httparty'

module Marvel
  class BaseService
    include HTTParty

    BASE_URL = 'https://gateway.marvel.com/v1/public'
    PUBLIC_KEY = 'd0db61fb1cbeb690d6dc7197e102e3b5'
    PRIVATE_KEY = '77a759fecfa94e9d4b5c37cf1b5e42ad1f86f4fe'

    def generate_hash(timestamp)
      Digest::MD5.hexdigest(timestamp + PRIVATE_KEY + PUBLIC_KEY)
    end

    def query_params(additional_params = {})
      timestamp = Time.now.to_i.to_s
      {
        ts: timestamp,
        apikey: PUBLIC_KEY,
        hash: generate_hash(timestamp)
      }.merge(additional_params)
    end
  end
end
