require 'digest/md5'
require 'httparty'

class MarvelApiService
  BASE_URL = 'https://gateway.marvel.com/v1/public'
  PUBLIC_KEY = 'd0db61fb1cbeb690d6dc7197e102e3b5'
  PRIVATE_KEY = '77a759fecfa94e9d4b5c37cf1b5e42ad1f86f4fe'

  def initialize(character_name)
    @character_name = character_name
  end

  def fetch_character_data
    response = HTTParty.get("#{BASE_URL}/characters", query: query_params)
    return nil unless response.success? && response['data']['results'].any?

    character_data = response['data']['results'].first
    {
      image_url: "#{character_data['thumbnail']['path']}.#{character_data['thumbnail']['extension']}",
      marvel_description: character_data['description']
    }
  end

  private

  def query_params
    timestamp = Time.now.to_i.to_s
    hash = generate_hash(timestamp)
    {
      name: @character_name,
      ts: timestamp,
      apikey: PUBLIC_KEY,
      hash: hash
    }
  end

  def generate_hash(timestamp)
    Digest::MD5.hexdigest(timestamp + PRIVATE_KEY + PUBLIC_KEY)
  end
end
