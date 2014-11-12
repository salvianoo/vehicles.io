Sequel.migration do
  change do
    add_column :users, :password_salt, :null => false, String
    add_column :users, :password_hash, :null => false, String

    drop_column :users, :password
  end
end
