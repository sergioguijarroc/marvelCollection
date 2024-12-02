class MarvelServices::GetCharacterSeries
  def initialize(character_name)
    @character_name = character_name
  end

  def call
    character_data = MarvelAdapters::CharacterAdapter.new(@character_name).request
    series_items = character_data['series']['items']
    # Devuelve un array con hashes, que contiene las claves de resourceURI y name
    series_items.map { |serie| serie['name'] } # Esto retorna un array de strings con los nombres de las series
  end
end
