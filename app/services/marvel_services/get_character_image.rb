class MarvelServices::GetCharacterImage
  def initialize(character_name)
    super()
    @character_name = character_name
  end

  def call
    character_data = MarvelAdapters::CharacterAdapter.new(@character_name).request
    "#{character_data['thumbnail']['path']}.#{character_data['thumbnail']['extension']}"
  end
end
