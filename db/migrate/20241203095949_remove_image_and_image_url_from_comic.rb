class RemoveImageAndImageUrlFromComic < ActiveRecord::Migration[6.1]
  def change
    remove_column :comics, :image, :string
    remove_column :comics, :image_url, :string
  end
end
