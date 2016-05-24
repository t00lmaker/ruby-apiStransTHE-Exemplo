
require 'sinatra'
require './client'
require 'json'

get '/' do
  erb :index
end

# Servicos Basicos Da API

get '/paradasProximo.json' do
  ClientAPi.instance
end
get '/linhas.json' do
  ClientAPi.instance.get(:linhas, params[:busca]).to_json
end

get '/paradas.json' do
  ClientAPi.instance.get(:paradas, params[:busca]).to_json
end

get '/paradasLinha.json' do
  if !params[:busca]
    status 403
    body "Informe Parametro busca na url"
  else
    ClientAPi.instance.get(:paradas_linha, params[:busca]).to_json
  end
end

get '/veiculos.json' do
  ClientAPi.instance.get(:veiculos).to_json
end

get '/veiculosLinha.json' do
  if !params[:busca]
    status 403
    body "Informe Parametro busca na url"
  else
    ClientAPi.instance.get(:veiculos_linha, params[:busca]).to_json
  end
end

# Servicos não oferecidos diretamente pela API.

get '/paradasProximas.json' do
  if !params[:long] || !params[:lat] || !params[:dist]
    status 403
    body "Informe os parametros 'long' (Longitude), 'lat'(Latitude), e 'dist'(Distancia)."
  else
    ClientAPi.instance.paradas_proximas(params[:long], params[:lat], params[:dist]).to_json
  end
end

# Retornas as Linhas que passam em uma parada especificada.
get '/linhasParada.json' do
  if !params[:codigoParada]
    status 403
    body "Informe parametro 'codigoParada' na url."
  else
    ClientAPi.instance.linhas_parada(params[:codigoParada]).to_json
  end
end

# Retorna as paradas próximas de uma localização.
get '/paradasProximas.json' do
  if !params[:long] || !params[:lat] || !params[:dist]
    status 403
    body "Informe todos os parametro ('long', 'lat' e 'dist') na url"
  else
    { 'paradas' => ClientAPi.instance.paradas_proximas(params[:long], params[:lat], params[:dist])}.to_json
  end
end

# Retorna as linhas que passam em uma parada com o código especificado.
get '/linhasParada.json' do
  if !params[:codigoParada]
    status 403
    body "Informe Parametro 'codigoParada' na url"
  else
    { 'linhas' => ClientAPi.instance.linhas_parada(params[:long], params[:lat], params[:dist])}.to_json
  end
end

# Em especial para tio Douglas.

get '/mobile/paradasProximas.json' do
  if !params[:long] || !params[:lat] || !params[:dist]
    status 403
    body "Informe todos os parametro ('long', 'lat' e 'dist') na url"
  else
    { 'paradas' => ClientAPi.instance.paradas_proximas(params[:long], params[:lat], params[:dist])}.to_json
  end
end

get '/mobile/linhasParada.json' do
  if !params[:codigoParada]
    status 403
    body "Informe Parametro 'codigoParada' na url"
  else
    { 'linhas' => ClientAPi.instance.linhas_parada(params[:codigoParada])}.to_json
  end
end

get '/mobile/veiculosLinha.json' do
  if !params[:codigoLinha]
    status 403
    body "Informe parametro 'codigoLinha' na url."
  else
    {'veiculos' => ClientAPi.instance.get(:veiculos_linha, params[:codigoLinha])}.to_json
  end
end
