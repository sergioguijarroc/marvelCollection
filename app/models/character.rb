class Character < ApplicationRecord
  has_rich_text :description
  belongs_to :user
  has_many :appearances, dependent: :destroy
  has_many :comics, through: :appearances
  attr_accessor :comic_elements

  accepts_nested_attributes_for :appearances, allow_destroy: true

  validates :name, :description, :user_id, presence: true
end
