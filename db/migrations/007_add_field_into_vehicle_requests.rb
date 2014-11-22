Sequel.migration do
  change do
    add_column :vehicle_requests, :servico, String, null: false
  end
end
