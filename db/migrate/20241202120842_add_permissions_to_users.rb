# frozen_string_literal: true

class AddPermissionsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :permissions, :text
  end
end
