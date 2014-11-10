class Cidade < Sequel::Model
  many_to_one :estado
end
