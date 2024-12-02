class AddSeriesToCharacter < ActiveRecord::Migration[6.1]
  def change
    add_column :characters, :series, :text
  end
end
