class RemoveMarvelDescriptionFromCharacters < ActiveRecord::Migration[6.1]
  def change
    remove_column :characters, :marvel_description, :text
  end
end
