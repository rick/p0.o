require 'rubygems'
require 'isolate/now'
require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/base'
require 'padrino-helpers'
require 'haml'

class PledgeNothing < Sinatra::Base
  register Padrino::Helpers

  get '/' do
    haml :index
  end

  get '/pledges/new' do
    haml :new_pledge, :layout => false
  end

  post '/pledges/create' do
    raise "Shit"
  end
end

