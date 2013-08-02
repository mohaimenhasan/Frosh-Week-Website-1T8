namespace :db do

  desc "Seed admins"
  task :seed_admins => :environment do
    Admin.delete_all
    ActiveRecord::Base.connection.reset_pk_sequence! Admin.table_name

    Admin.create(email: 'me@amandeep.ca')
    Admin.create(email: 'technology@orientation.skule.ca')
  end

end
