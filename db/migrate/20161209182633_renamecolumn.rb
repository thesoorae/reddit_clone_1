class Renamecolumn < ActiveRecord::Migration
  def change
    rename_column :users, :password, :password_digest
    add_index :users, :session_token, unique: true 
  end

end
