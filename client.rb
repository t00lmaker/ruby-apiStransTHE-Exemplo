
require "singleton"
require "strans-client"


#Simples Singleton para garantir
# que a validação do token está funcionando,
# pois a api já faz o gerenciamento do Token.
class ClientAPi
  include Singleton

  def initialize
    @client = StransClient.new('luanpontes2@gmail.com', 'naul1991', '49ea6f5525a34e71bdd7b4f8a92adaac')
  end

  def get(path, busca=nil)
    @client.get(path, busca)
  end
end
