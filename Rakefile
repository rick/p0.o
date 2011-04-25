require 'rubygems'
require 'isolate/now'

namespace :deploy do
  task :notify_passenger_of_restart do
    system("touch tmp/restart.txt")
  end

  task :post_deploy => [ :notify_passenger_of_restart ]
end
