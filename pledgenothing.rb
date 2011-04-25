require 'rubygems'
require 'isolate/now'
require 'sinatra'
require 'haml'

get '/' do
  haml :index
end

