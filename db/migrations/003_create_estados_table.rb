Sequel.migration do
  up do
    create_table :estados do
      primary_key :id
      String :sigla, null: false
      String :nome,  null: false
    end
  end

  down do
    drop_table :estados
  end
end
