class Character < ApplicationRecord
  has_rich_text :description
  belongs_to :user
  has_many :appearances, dependent: :destroy
  has_many :comics, through: :appearances
  attr_accessor :comic_elements

  after_save :save_comics

  def save_comics
    return appearances.destroy_all if comic_elements.nil? || comic_elements.empty?

    appearances.where.not(comic_id: comic_elements).destroy_all

    comic_elements.each do |comic_id|
      # unless Appearance.where(character: self, comic_id: comic_id).any?
      #   Appearance.create(character: self, comic_id: comic_id)
      # end
      # Esta forma es mejor
      Appearance.find_or_create_by(comic_id: comic_id, character: self)
    end
  end

  validates :name, :description, :user_id, presence: true
end
