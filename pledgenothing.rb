require 'rubygems'
require 'isolate/now'
require 'sinatra'
require 'haml'

get '/' do
  "Hello world, it's now #{Time.now}."
end

