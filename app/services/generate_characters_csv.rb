require 'smarter_csv'
require 'fileutils'

class GenerateCharactersCsv
  CSV_OPTIONS = {
    map_headers: {
      user_id: 'Creator ID',
      name: 'Name',
      description: 'Description',
      image_url: 'Image URL'
    }
  }.freeze
  def initialize(characters)
    @characters = characters
  end

  def call
    file_path = "csv/character-list-#{Time.now.strftime('%d%m%Y-%H%M%S')}.csv"
    FileUtils.mkdir_p('csv') unless File.directory?('csv')

    characters_data = @characters.find_each(batch_size: 100).map do |character|
      {
        user_id: character.user_id,
        name: character.name,
        description: character.description,
        image_url: character.image_url
      }
    end

    SmarterCSV.generate(file_path, CSV_OPTIONS) do |csv|
      characters_data.each do |character_data|
        csv << character_data
      end
    end
  end
end
