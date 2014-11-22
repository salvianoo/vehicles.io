Sequel.migration do
  change do
    add_column :vehicle_requests, :data, String, null: true
  end
end
