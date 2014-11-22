class Passenger < Sequel::Model
  many_to_one :passenger

  plugin :validation_helpers

  def validate
    super
    validates_presence [:name]
  end
end
