class AddUserIdToCharacter < ActiveRecord::Migration[6.1]
  def change
    # Verificar si la columna ya existe
    return if column_exists?(:characters, :user_id)

    add_reference :characters, :user, null: false, foreign_key: true
  end
end
