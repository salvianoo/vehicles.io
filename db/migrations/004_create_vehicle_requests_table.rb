Sequel.migration do
  up do
    create_table :vehicle_requests do
      primary_key :id
      String :departamento, null: false
      String :destino, null: false
    end
  end

  down do
    drop_table :vehicle_requests
  end
end
