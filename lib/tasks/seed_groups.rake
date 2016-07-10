namespace :db do

  desc "Seed Groups"
  task :seed_groups => :environment do
    Group.delete_all
    ActiveRecord::Base.connection.reset_pk_sequence! Group.table_name

    Group.create(symbol: '&alpha;', name: 'Alpha')
    Group.create(symbol: '&beta;', name: 'Beta')
    Group.create(symbol: '&gamma;', name: 'Gamma')
    Group.create(symbol: '&Delta;', name: 'Delta')
    Group.create(symbol: '&theta;', name: 'Theta')
    Group.create(symbol: '&kappa;', name: 'Kappa')
    Group.create(symbol: '&lambda;', name: 'Lambda')
    Group.create(symbol: '&Nu;', name: 'Ni')
    Group.create(symbol: '&Omicron;', name: 'Omicron')
    Group.create(symbol: '&pi;', name: 'Pi')
    Group.create(symbol: '&rho;', name: 'Rho')
    Group.create(symbol: '&Sigma;', name: 'Sigma')
    Group.create(symbol: '&tau;', name: 'Tau')
    Group.create(symbol: '&phi;', name: 'Phi')
    Group.create(symbol: '&chi;', name: 'Chi')
    Group.create(symbol: '&Psi;', name: 'Psi')
    Group.create(symbol: '&Omega;', name: 'Omega')

    Group.find_each do |g|
      g.facebook_link = "https://www.facebook.com/groups/#{g.name.downcase}.1t6"
      g.save!
    end
  end

end
