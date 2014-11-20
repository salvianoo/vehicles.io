class VehicleRequest < Sequel::Model
  one_to_many :passengers

  plugin :nested_attributes
  nested_attributes :passengers

  def initialize(params = {})
    @departamento = params[:departamento]
    @destino      = params[:destino]
    @passengers   = params[:passageiros]

    super(values)
  end

  # To create new passenger instances related to the VehicleRequest object
  # You need to do the following:
  #
  #  request = VehicleRequest.new(params)
  #
  #  request.passengers_attributes = [{name: 'Joao'}, {name: 'Maria'}]
  #
  # It can be better with the method defined below.
  # After define the 'request' object, call the method
  #
  #  request.create_nested_passengers
  #
  # The map function will return an array in the correct format.
  # Now you can retrieve passengers nested to the 'request' object
  #
  #  request.passengers
  #
  def create_nested_passengers
    self.passengers_attributes = @passengers.map {|p_name| {name: p_name}}
  end

  private

  def values
    {
      departamento: @departamento,
      destino: @destino
    }
  end
end
