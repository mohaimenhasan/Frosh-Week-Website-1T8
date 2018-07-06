# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

HhfPackageItem.delete_all
HhfPackage.delete_all

ActiveRecord::Base.connection.reset_pk_sequence! HhfPackage.table_name
ActiveRecord::Base.connection.reset_pk_sequence! HhfPackageItem.table_name


leedur = 60
fweek = 35
leedur_name = 'Leedurs Hart House Farm Retreat w/ Transportation'
fweek_name = 'Leedurs Hart House Farm Retreat w/out Transportation'

leedur_max = 50
fweek_max = 40

leedurbus = 46
fweekbus = 30
# BASIC ITEMS FOR SELECTION
HhfPackageItem.create(
  key: 'leedur',
  name: leedur_name ,
  description: '',
  price: leedur,
  count: 0,
  max: leedur_max,
  left: leedur_max,
  start_date: Date.strptime('05-01-2018', '%m-%d-%Y'),
  end_date: Date.strptime('07-15-2018', '%m-%d-%Y'),
)

HhfPackageItem.create(
  key: 'fweek',
  name: fweek_name ,
  description: '',
  price: fweek,
  count: 0,
  max: fweek_max,
  left: fweek_max,
  start_date: Date.strptime('05-01-2018', '%m-%d-%Y'),
  end_date: Date.strptime('09-09-2018', '%m-%d-%Y'),
)

# All Combo
HhfPackage.create(
  key: 'leedur',
  name: leedur_name,
  price: leedur,
)

HhfPackage.create(
  key: 'fweek',
  name: fweek_name,
  price: fweek
)
HhfPackage.create(
  key: 'leedur_fweek',
  name: leedur_name + ' + ' + fweek_name,
  price: leedur + fweek
)


Group.delete_all
Package.delete_all
PackageItem.delete_all
ActiveRecord::Base.connection.reset_pk_sequence! Group.table_name
ActiveRecord::Base.connection.reset_pk_sequence! Package.table_name
ActiveRecord::Base.connection.reset_pk_sequence! PackageItem.table_name


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

early = 100
normal = 120
hhf_addon = 35
commuter_addon = 145
early_bird_max = 200
regular_max = 725
commuter_max = 30
hhf_max = 150
unlimited = -1

# BASIC ITEMS FOR SELECTION
PackageItem.create(
  key: 'early-bird-standalone',
  name: 'Early Bird Standalone Package',
  description: 'A standard F!rosh Kit. Includes entrance to all events (like a parade!), a collection of cool things (like a hard hat!), and lots more! This kit has tons of awesome stuff!',
  price: early,
  count: 0,
  max: early_bird_max,
  left: early_bird_max,
  start_date: Date.strptime('05-01-2018', '%m-%d-%Y'),
  end_date: Date.strptime('08-31-2018', '%m-%d-%Y'),
)

PackageItem.create(
  key: 'standalone',
    name: 'Regular Standalone Package',
  description: 'A standard F!rosh Kit. Includes entrance to all events (like a parade!), a collection of cool things (like a hard hat!), and lots more! This kit has tons of awesome stuff!',
  price: normal,
  count: 0,
  max: 0,
  left: unlimited,
  start_date: Date.strptime('05-01-2018', '%m-%d-%Y'),
  end_date: Date.strptime('08-31-2018', '%m-%d-%Y'),
)
PackageItem.create(
  key: 'farm',
  name: 'Hart House Farm Retreat',
  description: 'A ticket to a camping trip at Hart House Farm, located outside of Caledon on the scenic Niagara Escarpment. Come join us for some fun camping on September 12 and 13 to cap off F!rosh Week!',
  price: hhf_addon ,
  count: 0,
  max: hhf_max,
  left: hhf_max,
  start_date: Date.strptime('05-01-2018', '%m-%d-%Y'),
  end_date: Date.strptime('08-31-2018', '%m-%d-%Y'),
)
PackageItem.create(
  key: 'commuter',
  name: 'Commuter Program Package',
  description: "Living accommodations! This offer includes a stay at a downtown hostel for four nights (Sunday September 6 - Thursday September 10) including 3 breakfasts, 1 dinner and a chaperone supervision for the entirety of your stay, so you can fully enjoy F!rosh Week's days and nights!",
  price: commuter_addon,
  count: 0,
  max: commuter_max,
  left: commuter_max,
  start_date: Date.strptime('05-01-2018', '%m-%d-%Y'),
  end_date: Date.strptime('08-31-2018', '%m-%d-%Y'),
)


# PACKAGE
Package.create(
  key: 'early-bird-standalone',
  name: 'Early Bird Standalone Package',
  price: early,
  count: 0,
  start_date: Date.strptime('05-01-2018', '%m-%d-%Y'),
  end_date: Date.strptime('08-31-2018', '%m-%d-%Y'),
)

Package.create(
  key: 'early-bird-standalone_commuter',
  name: 'Early Bird Standalone Package + Commuter Program Package',
  price: early+commuter_addon,
  count: 0,
  start_date: Date.strptime('05-01-2018', '%m-%d-%Y'),
  end_date: Date.strptime('08-31-2018', '%m-%d-%Y'),
)

Package.create(
  key: 'early-bird-standalone_farm',
  name: 'Early Bird Standalone Package + Hart House Farm Retreat',
  price: early+hhf_addon,
  count: 0,
  start_date: Date.strptime('05-01-2018', '%m-%d-%Y'),
  end_date: Date.strptime('08-31-2018', '%m-%d-%Y'),
)

Package.create(
  key: 'early-bird-standalone_farm_commuter',
  name: 'Early Bird Standalone Package + Hart House Farm Retreat + Commuter Program Package' ,
  price: early+commuter_addon+hhf_addon,
  count: 0,
  start_date: Date.strptime('05-01-2018', '%m-%d-%Y'),
  end_date: Date.strptime('08-31-2018', '%m-%d-%Y'),
)
#STANDALONE
Package.create(
  key: 'standalone',
  name: 'Regular Standalone Package',
  price: normal,
  count: 0,
  start_date: Date.strptime('05-01-2018', '%m-%d-%Y'),
  end_date: Date.strptime('08-31-2018', '%m-%d-%Y'),
)

Package.create(
  key: 'standalone_commuter',
  name: 'Standalone Package + Commuter Program Package',
  price: normal+commuter_addon,
  count: 0,
  start_date: Date.strptime('05-01-2018', '%m-%d-%Y'),
  end_date: Date.strptime('08-31-2018', '%m-%d-%Y'),
)

Package.create(
  key: 'standalone_farm',
  name: 'Standalone Package + Hart House Farm Retreat',
  price: normal+hhf_addon,
  count: 0,
  start_date: Date.strptime('05-01-2018', '%m-%d-%Y'),
  end_date: Date.strptime('08-31-2018', '%m-%d-%Y'),
)

Package.create(
  key: 'standalone_farm_commuter',
  name: 'Standalone Package + Hart House Farm Retreat + Commuter Program Package',
  price: normal+commuter_addon+hhf_addon,
  count: 0,
  start_date: Date.strptime('05-01-2018', '%m-%d-%Y'),
  end_date: Date.strptime('08-31-2018', '%m-%d-%Y'),
)
