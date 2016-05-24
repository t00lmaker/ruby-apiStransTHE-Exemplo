
require "singleton"
require "lazy-strans-client"


#Simples Singleton para garantir
# que a validação do token está funcionando,
# pois a api já faz o gerenciamento do Token.
class ClientAPi
  include Singleton

  def initialize
    @client = LazyStransClient.new('luanpontes2@gmail.com', 'naul1991', '49ea6f5525a34e71bdd7b4f8a92adaac')
    @client.load()
  end

  #chamdadas a servico padroes da API
  def get(path, busca=nil)
    @client.get(path, busca)
  end

  #servicos oferencidos pela GEM.

  def paradas_proximas(long, lat, dist)
    @client.paradas_proximas(long, lat, dist)
  end

  def linhas_parada(codigoParada)
    @client.linhas_parada(codigoParada)
  end

end
