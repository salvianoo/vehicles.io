Sequel.migration do
  change do
    alter_table :vehicle_requests do
      add_foreign_key :user_id, :vehicle_requests
    end
  end
end
