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
