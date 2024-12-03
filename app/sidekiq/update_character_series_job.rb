# frozen_string_literal: true

# < ActiveJob::Base
class UpdateCharacterSeriesJob
  include Sidekiq::Job
  sidekiq_options retry: 3

  def perform(character_id)
    character = Character.find(character_id)
    series = MarvelServices::GetCharacterSeries.new(character.name).call

    if series.present?
      character.update(series: series)
      Rails.logger.info "Updated series for character #{character.name}: #{series.count} series found"
    else
      Rails.logger.warn "No series found for character #{character.name}"
    end
  rescue StandardError => e
    Rails.logger.error "Failed to update series for character #{character_id}: #{e.message}"
    raise e
  end
end
