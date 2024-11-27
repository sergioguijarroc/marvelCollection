class AddImageUrlToComics < ActiveRecord::Migration[6.1]
  def change
    add_column :comics, :image_url, :string
  end
end
