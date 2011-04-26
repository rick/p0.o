require 'rubygems'
require 'isolate/now'
require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/activerecord/rake'

namespace :deploy do
  task :notify_passenger_of_restart do
    puts "Notifying Passenger..."
    system("touch tmp/restart.txt")
  end

  task :post_deploy => [ 'db:migrate', :notify_passenger_of_restart ]
end
