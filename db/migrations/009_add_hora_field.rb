Sequel.migration do
  change do
    add_column :vehicle_requests, :hora, String, null: true
  end
end
