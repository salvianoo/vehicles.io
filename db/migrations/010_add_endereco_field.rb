Sequel.migration do
  change do
    add_column :vehicle_requests, :endereco, String, null: true
  end
end
