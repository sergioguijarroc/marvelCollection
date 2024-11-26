require 'digest/md5'

class MarvelApiService
  BASE_URL = 'https://gateway.marvel.com/v1/public'
  PUBLIC_KEY = 'your_public_key'
  PRIVATE_KEY = 'your_private_key'

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
