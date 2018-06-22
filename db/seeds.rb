# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Group.delete_all
Package.delete_all
ActiveRecord::Base.connection.reset_pk_sequence! Group.table_name
ActiveRecord::Base.connection.reset_pk_sequence! Package.table_name

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
  g.facebook_link = "http://facebook.com/groups/#{g.name.downcase}.1t8"
  #g.facebook_link = "http://facebook.com/groups/1t8.#{g.name.downcase}" if g.name == 'Phi'
  g.save!
end

early = 97
normal = 124
hhf_addon = 40
commuter_addon = 130
hhf_commuter_addon = 170
early_bird_max = 200

Package.create(
  key: 'early-bird-standalone',
  name: 'F!rosh Kit Early Bird Standalone Package',
  description: 'A standard F!rosh Kit. Includes entrance to all events (like a parade!), a collection of cool things (like a hard hat!), and lots more! This kit has tons of awesome stuff!',
  price: early,
  count: 0,
  max: early_bird_max,
  start_date: Date.strptime('05-01-2018', '%m-%d-%Y'),
  end_date: Date.strptime('08-21-2018', '%m-%d-%Y'),
)
Package.create(
  key: 'early-bird-with-farm',
  name: 'F!rosh Kit Early Bird + Hart House Farm Package',
  description: 'A standard F!rosh Kit... except even better! This package includes a ticket to a camping trip at Hart House Farm, located outside of Caledon on the scenic Niagara Escarpment. Come join us for some fun camping on September 12 and 13 to cap off F!rosh Week!',
  price: early + hhf_addon,
  count: 0,
  max: early_bird_max,
  start_date: Date.strptime('05-01-2018', '%m-%d-%Y'),
  end_date: Date.strptime('08-21-2018', '%m-%d-%Y'),
)
Package.create(
  key: 'early-bird-with-commuter',
  name: 'F!rosh Kit Early Bird + Commuter Program Package',
  description: "A standard F!rosh Kit... with living accommodations! This offer includes room and board at a downtown hostel for four nights so you can fully enjoy F!rosh Week's days and nights.",
  price: early + commuter_addon,
  count: 0,
  max: early_bird_max,
  start_date: Date.strptime('05-01-2018', '%m-%d-%Y'),
  end_date: Date.strptime('08-21-2018', '%m-%d-%Y'),
)
Package.create(
  key: 'early-bird-all',
  name: 'F!rosh Kit Early Bird + Hart House Farm + Commuter Program Package',
  description: 'This is for the F!rosh that wants to have the ultimate F!rosh Week experience. You get a standard F!rosh kit, accommodations throughout the week, and a ticket to the weekend Hart House Farm camping trip. Super fun!',
  price: early + hhf_commuter_addon,
  count: 0,
  max: early_bird_max,
  start_date: Date.strptime('05-01-2018', '%m-%d-%Y'),
  end_date: Date.strptime('08-21-2018', '%m-%d-%Y'),
)


Package.create(
  key: 'standalone',
  name: 'F!rosh Kit Standalone Package',
  description: 'A standard F!rosh Kit. Includes entrance to all events (like a parade!), a collection of cool things (like a hard hat!), and lots more! This kit has tons of awesome stuff!',
  price: normal,
  count: 0,
  max: 0,
  start_date: Date.strptime('05-01-2018', '%m-%d-%Y'),
  end_date: Date.strptime('08-21-2018', '%m-%d-%Y'),
)
Package.create(
  key: 'farm',
  name: 'F!rosh Kit + Hart House Farm Package',
  description: 'A standard F!rosh Kit just like above... except even better! This package includes a ticket to a camping trip at Hart House Farm, located outside of Caledon on the scenic Niagara Escarpment. Come join us for some fun camping on September 12 and 13 to cap off F!rosh Week!',
  price: normal + hhf_addon ,
  count: 0,
  max: 0,
  start_date: Date.strptime('05-01-2018', '%m-%d-%Y'),
  end_date: Date.strptime('08-21-2018', '%m-%d-%Y'),
)
Package.create(
  key: 'commuter',
  name: 'F!rosh Kit + Commuter Program Package',
  description: "A standard F!rosh Kit... with living accommodations! This offer includes room and board at a downtown hostel for four nights so you can fully enjoy F!rosh Week's days and nights.",
  price: normal + commuter_addon,
  count: 0,
  max: 0,
  start_date: Date.strptime('05-01-2018', '%m-%d-%Y'),
  end_date: Date.strptime('08-21-2018', '%m-%d-%Y'),
)
Package.create(
  key: 'all',
  name: 'F!rosh Kit + Hart House Farm + Commuter Program Package',
  description: 'This is for the F!rosh that wants to have the ultimate F!rosh Week experience. You get a standard F!rosh kit, accommodations throughout the week, and a ticket to the weekend Hart House Farm camping trip. Super fun!',
  price: normal + hhf_commuter_addon,
  count: 0,
  max: 0,
  start_date: Date.strptime('05-01-2018', '%m-%d-%Y'),
  end_date: Date.strptime('08-21-2018', '%m-%d-%Y'),
)
