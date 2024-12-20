# frozen_string_literal: true

class CreateAppearances < ActiveRecord::Migration[6.1]
  def change
    create_table :appearances do |t|
      t.references :character, null: false, foreign_key: true
      t.references :comic, null: false, foreign_key: true

      t.timestamps
    end
  end
end
