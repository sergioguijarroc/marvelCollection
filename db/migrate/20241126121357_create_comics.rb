class CreateComics < ActiveRecord::Migration[6.1]
  def change
    create_table :comics do |t|
      t.string :title
      t.date :release_date
      t.text :description

      t.timestamps
    end
  end
end
