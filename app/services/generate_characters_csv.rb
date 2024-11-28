require 'smarter_csv'
require 'fileutils'

class GenerateCharactersCsv
  CSV_OPTIONS = {
    map_headers: {
      name: 'Name',
      description: 'Description',
      image_url: 'Image URL'
    }
  }.freeze
  def initialize
    @characters = Character.all
  end

  def call
    file_path = "csv/character-list-#{Date.today}.csv"
    FileUtils.mkdir_p('csv') unless File.directory?('csv')

    characters_data = @characters.find_each(batch_size: 100).map do |character|
      {
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
