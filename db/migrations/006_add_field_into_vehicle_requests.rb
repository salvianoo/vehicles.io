Sequel.migration do
  change do
    add_column :vehicle_requests, :motivo_da_viagem, String, null: false
  end
end
