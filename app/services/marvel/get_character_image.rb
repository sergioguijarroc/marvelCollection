module Marvel
  class GetCharacterImage < BaseService # Cambiar nombre
    def initialize(character_name)
      super()
      @character_name = character_name
    end

    def call
      response = HTTParty.get("#{BASE_URL}/characters", query: query_params(name: @character_name))
      return nil unless response.success? && response['data']['results'].any?

      character_data = response['data']['results'].first

      "#{character_data['thumbnail']['path']}.#{character_data['thumbnail']['extension']}"
    end
  end
end
