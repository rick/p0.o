require 'rubygems'
require 'isolate/now'
require 'sinatra'
require 'sinatra/activerecord'
require 'haml'

get '/' do
  haml :index
end

