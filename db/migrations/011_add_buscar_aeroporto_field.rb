Sequel.migration do
  change do
    add_column :vehicle_requests, :buscar_aeroporto, String, null: true
  end
end
