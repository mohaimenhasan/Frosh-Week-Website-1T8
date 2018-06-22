namespace :db do

  desc "Seed Groups"
  task :seed_groups => :environment do
    Group.delete_all
    ActiveRecord::Base.connection.reset_pk_sequence! Group.table_name

    Group.create(symbol: '&alpha;', name: 'Alpha', code: 'GODIVAGODIVAGODIVA')
    Group.create(symbol: '&beta;', name: 'Beta', code: 'ULTIMATE_FROSH')
    Group.create(symbol: '&chi;', name: 'Chi', code: 'TOIKE_OIKE')
    Group.create(symbol: '&Delta;', name: 'Delta', code: 'SOLAR_CAR')
    Group.create(symbol: '&gamma;', name: 'Gamma', code: 'ENGSOC')
    Group.create(symbol: '&kappa;', name: 'Kappa', code: 'SATELLITE_DESIGN')
    Group.create(symbol: '&lambda;', name: 'Lambda', code: 'FROSH_HANDBOOK')
    Group.create(symbol: '&Nu;', name: 'Ni', code: 'RUREADYTODYE')
    Group.create(symbol: '&pi;', name: 'Pi', code: 'MR_B&G')
    Group.create(symbol: '&rho;', name: 'Rho', code: 'IRON_RING')
    Group.create(symbol: '&Sigma;', name: 'Sigma', code: 'LADY_GODIVA_MEMORIAL_BNAD')
    Group.create(symbol: '&tau;', name: 'Tau', code: 'S_K_U_L_E')
    Group.create(symbol: '&phi;', name: 'Phi', code: 'HARDHAT<3')
    Group.create(symbol: '&Psi;', name: 'Psi', code: 'SKULE_CANNON_TM')
    Group.create(symbol: '&Omega;', name: 'Omega', code: 'S_U_D_S')
    Group.create(symbol: '&Omnicron;', name: 'Omicron', code: 'EAA_SPORTS')
    Group.create(symbol: '&theta;', name: 'Theta', code: 'ROCK_OF_AJAX')
    Group.create(symbol: '&zeta;', name: 'Zeta', code: 'HARDHATCAFE')

    Group.find_each do |g|
      g.facebook_link = "https://www.facebook.com/groups/#{g.name.downcase}.1t8"
      g.save!
    end
  end

end
