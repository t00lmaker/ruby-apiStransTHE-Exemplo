

require 'sinatra'
require 'strans-client'

get '/' do
  erb :index
end

get '/linhas.json' do
  client = StransClient.new('luanpontes2@gmail.com', 'naul1991', '49ea6f5525a34e71bdd7b4f8a92adaac')
  client.autentic
  client.linhas(params[:busca]).to_s
end

get '/paradas.json' do
  client = StransClient.new('luanpontes2@gmail.com', 'naul1991', '49ea6f5525a34e71bdd7b4f8a92adaac')
  client.autentic
  client.paradas(params[:busca]).to_s
end

get '/paradasLinha.json' do
  if !params[:busca]
    status 403
    body "Informe Parametro busca na url"
  else
    client = StransClient.new('luanpontes2@gmail.com', 'naul1991', '49ea6f5525a34e71bdd7b4f8a92adaac')
    client.autentic
    client.paradas_linha(params[:busca]).to_s
  end
end

get '/veiculos.json' do
  client = StransClient.new('luanpontes2@gmail.com', 'naul1991', '49ea6f5525a34e71bdd7b4f8a92adaac')
  client.autentic
  client.veiculos().to_s
end

get '/veiculosLinha.json' do
  if !params[:busca]
    status 403
    body "Informe Parametro busca na url"
  else
    client = StransClient.new('luanpontes2@gmail.com', 'naul1991', '49ea6f5525a34e71bdd7b4f8a92adaac')
    client.autentic
    client.veiculos_linha(params[:busca]).to_s
  end
end
