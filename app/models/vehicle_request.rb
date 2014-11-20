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

  # To create new passengers instances related to the VehicleRequest object
  # I need to do some like this:
  #
  #  request = VehicleRequest.new(params)
  #
  #  request.passengers_attributes = [{name: 'Joao'}, {name: 'Maria'}]
  #
  # With this method it could be better, after define the request object,
  # just call it.
  #
  #  request.create_nested_passengers
  #
  # The map function will return an array in the format above.
  # Now i can retrieve the passengers nested to the current object
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
