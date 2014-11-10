require_relative "../config/database"
require_relative "../app/models/cidade"
require_relative "../app/models/estado"

e = Estado.create(sigla: 'AC', nome: 'Acre')
puts e
# e = DB[:estados].insert(sigla: 'AC', nome: "Acre")

# e_id = DB[:estados][sigla: 'AC']

e_id = DB[:estado][:id]
e = Estado.create

e.cidades.insert(:nome => "Acrelandia")

