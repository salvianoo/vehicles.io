Sequel.migration do
  up do
    create_table :cidades do
      primary_key :id
      foreign_key :estado_id, :estados
      String :nome, null: false
    end
  end

  down do
    drop_table :cidades
  end
end
