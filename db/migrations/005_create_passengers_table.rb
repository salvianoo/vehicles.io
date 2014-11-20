Sequel.migration do
  up do
    create_table :passengers do
      primary_key :id
      foreign_key :vehicle_request_id, :vehicle_requests
      String :name, null: false
    end
  end

  down do
    drop_table :passengers
  end
end
