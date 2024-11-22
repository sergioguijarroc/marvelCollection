class Character < ApplicationRecord
  has_rich_text :description
  belongs_to :user
  validates :user_id, presence: true
end
