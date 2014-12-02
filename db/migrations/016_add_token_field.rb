Sequel.migration do
  change do
    add_column :vehicle_requests, :token, String, null: true
  end
end
