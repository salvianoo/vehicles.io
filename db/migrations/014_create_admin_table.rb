Sequel.migration do
  up do
    create_table :admins do
      primary_key :id
      String :nome, null: false
      String :email, null: false
      String :password_salt, null: false
      String :password_hash, null: false
    end
  end

  down do
    drop_table :admins
  end
end
