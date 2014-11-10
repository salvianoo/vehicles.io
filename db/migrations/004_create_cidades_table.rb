Sequel.migration do
  up do
    create_table :cidades do
      primary_key :id
      String :nome, null: false
    end
  end

  down do
    drop_table :estados
  end
end
