Sequel.migration do
  change do
    add_column :users, :password_salt, String, :null => false
    add_column :users, :password_hash, String, :null => false

    drop_column :users, :password
  end
end
