class Comic < ApplicationRecord
  has_many :appearances
  has_many :characters, through: :appearances
end
