Sequel.migration do
  change do
    add_column :vehicle_requests, :numero_voo, String, null: true
  end
end
