Sequel.migration do
  change do
    add_column :vehicle_requests, :cia_area, String, null: true
  end
end
