require 'securerandom'

class VehicleRequest < Sequel::Model
  many_to_one :user
  one_to_many :passengers

  plugin :nested_attributes
  nested_attributes :passengers

  def initialize(params = {})
    @departamento     = params[:departamento]
    @destino          = params[:destino]
    @passengers       = params[:passageiros]
    @motivo_da_viagem = params[:motivo_da_viagem]
    @servico          = params[:servico]
    @data             = params[:data]
    @hora             = params[:hora]
    @endereco         = params[:endereco]
    @buscar_aeroporto = params[:buscar_aeroporto]
    @cia_area         = params[:cia_area]
    @numero_voo       = params[:numero_voo]
    @token            = SecureRandom.urlsafe_base64

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

  def update_nested_passengers(updated_passengers)
    outdated_passengers = self.passengers

    update_attributes = updated_passengers
    .zip(outdated_passengers)
    .map { |update, old| {id: old.id, name: update} }

    self.update(:passengers_attributes => update_attributes)
  end

  def update_attributes(request_params)
    self.set_fields(request_params, vehicle_requests_fields)
  end

  private

  def values
    {
      departamento: @departamento,
      destino: @destino,
      motivo_da_viagem: @motivo_da_viagem,
      servico: @servico,
      data: @data,
      hora: @hora,
      endereco: @endereco,
      buscar_aeroporto: @buscar_aeroporto,
      cia_area: @cia_area,
      numero_voo: @numero_voo,
      token: @token
    }
  end

  def vehicle_requests_fields
    [:departamento,
     :destino,
     :motivo_da_viagem,
     :servico,
     :data,
     :hora,
     :endereco,
     :buscar_aeroporto,
     :cia_area,
     :numero_voo]
  end
end
