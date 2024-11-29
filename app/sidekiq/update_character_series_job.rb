class UpdateCharacterSeriesJob
  include Sidekiq::Job

  def perform(character_id)
    character = Character.find(character_id)
    series = MarvelServices::GetCharacterSeries.new(character.name).call
  end
end
