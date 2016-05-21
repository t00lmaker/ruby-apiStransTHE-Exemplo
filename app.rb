
require 'sinatra'
require './client'
require 'json'

get '/' do
  erb :index
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
