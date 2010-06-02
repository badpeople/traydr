require 'traydr.rb'

include Traydr

namespace :updater do
  task :update_1 => :environment do
    puts "doing update 1"
    all_users = User.find(:all)
    puts "num users: #{all_users.length()}"
    for user in all_users
      code = create_conf_code
      puts "#{user.username}=>#{code}"
      user.update_attributes(:conf_code=>code)
    end
  end
end