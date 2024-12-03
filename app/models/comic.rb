# frozen_string_literal: true

class Comic < ApplicationRecord
  has_many :appearances, dependent: :destroy
  has_many :characters, through: :appearances
end
