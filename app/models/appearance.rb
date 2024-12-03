# frozen_string_literal: true

class Appearance < ApplicationRecord
  belongs_to :character
  belongs_to :comic
end
