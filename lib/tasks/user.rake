#writing rake task to update existing user as confirmed'

namespace :users do
  desc "set all old user as confirmed by devise confirmable module"
  task :confirm_existing_user => :environment do
    User.update_all(:confirmed_at => Time.now)
  end
end