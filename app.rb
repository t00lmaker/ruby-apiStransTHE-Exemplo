
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

# Servicos Oferecidos pela API.

get '/paradasProximas' do
  if !params[:long] || !params[:lat] || !params[:dist]
    status 403
    body "Informe os parametros 'long' (Longitude), 'lat'(Latitude), e 'dist'(Distancia)."
  else
    ClientAPi.instance.paradas_proximas(params[:long], params[:lat], params[:dist]).to_json
  end
end

get '/linhasParada' do
  if !params[:codigoParada]
    status 403
    body "Informe parametro 'codigoParada' na url."
  else
    ClientAPi.instance.linhas_parada(params[:codigoParada]).to_json
  end
end

# Em especial para tio Douglas.

get '/douglas/paradasProximas.json' do
  if !params[:long] || !params[:lat] || !params[:dist]
    status 403
    body "Informe Parametro busca na url"
  else
    { 'paradas' => ClientAPi.instance.paradas_proximas(params[:long], params[:lat], params[:dist])}.to_json
  end
end

get '/douglas/veiculosLinha.json' do
  if !params[:codigoLinha]
    status 403
    body "Informe parametro 'codigoLinha' na url."
  else
    {'veiculos' => ClientAPi.instance.get(:veiculos_linha, params[:codigoLinha])}.to_json
  end
end
