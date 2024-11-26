class Character < ApplicationRecord
  has_rich_text :description
  belongs_to :user
  validates :name, :description, :user_id, presence: true
end
