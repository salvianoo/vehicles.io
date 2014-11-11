Sequel.migration do
  up do
    alter_table :cidades do
      add_foreign_key :estado_id, :estados
    end
  end

  down do
    drop_column :cidades, :estado_id
  end
end
