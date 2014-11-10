class Estado < Sequel::Model
  one_to_many :cidades
end
