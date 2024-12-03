# frozen_string_literal: true

module MarvelAdapters
  class CharacterAdapter < BaseAdapter
    def initialize(character_name)
      super()
      @character_name = character_name
    end

    def request
      response = HTTParty.get("#{BASE_URL}/characters", query: query_params(name: @character_name))
      return nil unless response.success? && response['data']['results'].any?

      response['data']['results'].first
    end
  end
end
