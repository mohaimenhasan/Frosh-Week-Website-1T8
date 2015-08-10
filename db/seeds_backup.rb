# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Group.delete_all
Package.delete_all
PackageItem.delete_all
ActiveRecord::Base.connection.reset_pk_sequence! Group.table_name
ActiveRecord::Base.connection.reset_pk_sequence! Package.table_name
ActiveRecord::Base.connection.reset_pk_sequence! PackageItem.table_name

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
  g.facebook_link = "https://www.facebook.com/groups/#{g.name.downcase}.1t5"
    #Thanks to our vp marketing, we have omicorn!!!
  g.facebook_link = "https://www.facebook.com/groups/omicorn.1t5" if g.name = "Omicron"
  g.save!
end

early = 95
normal = 125
hhf_addon = 40
commuter_addon = 145
early_bird_max = 200
#fake  regular_max = 600
commuter_max = 50
hhf_max = 250
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
  start_date: Date.strptime('05-01-2015', '%m-%d-%Y'),
  end_date: Date.strptime('08-31-2015', '%m-%d-%Y'),
)

PackageItem.create(
  key: 'standalone',
    name: 'Regular Standalone Package',
  description: 'A standard F!rosh Kit. Includes entrance to all events (like a parade!), a collection of cool things (like a hard hat!), and lots more! This kit has tons of awesome stuff!',
  price: normal,
  count: 0,
  max: 0,
  left: unlimited, 
  start_date: Date.strptime('05-01-2015', '%m-%d-%Y'),
  end_date: Date.strptime('08-31-2015', '%m-%d-%Y'),
)
PackageItem.create(
  key: 'farm',
  name: 'Hart House Farm Retreat',
  description: 'A ticket to a camping trip at Hart House Farm, located outside of Caledon on the scenic Niagara Escarpment. Come join us for some fun camping on September 12 and 13 to cap off F!rosh Week!',
  price: hhf_addon ,
  count: 0,
  max: hhf_max,
  left: hhf_max,
  start_date: Date.strptime('05-01-2015', '%m-%d-%Y'),
  end_date: Date.strptime('08-31-2015', '%m-%d-%Y'),
)
PackageItem.create(
  key: 'commuter',
  name: 'Commuter Program Package',
  description: "Living accommodations! This offer includes a stay at a downtown hostel for four nights (Sunday September 6 - Thursday September 10) including 3 breakfasts, 1 dinner and a chaperone supervision for the entirety of your stay, so you can fully enjoy F!rosh Week's days and nights!",
  price: commuter_addon,
  count: 0,
  max: commuter_max,
  left: commuter_max,
  start_date: Date.strptime('05-01-2015', '%m-%d-%Y'),
  end_date: Date.strptime('08-31-2015', '%m-%d-%Y'),
)


# PACKAGE
Package.create(
  key: 'early-bird-standalone',
  name: 'Early Bird Standalone Package',
  price: early,
  count: 0,
  start_date: Date.strptime('05-01-2015', '%m-%d-%Y'),
  end_date: Date.strptime('08-31-2015', '%m-%d-%Y'),
)

Package.create(
  key: 'early-bird-standalone_commuter',
  name: 'Early Bird Standalone Package + Commuter Program Package',
  price: early+commuter_addon,
  count: 0,
  start_date: Date.strptime('05-01-2015', '%m-%d-%Y'),
  end_date: Date.strptime('08-31-2015', '%m-%d-%Y'),
)

Package.create(
  key: 'early-bird-standalone_farm',
  name: 'Early Bird Standalone Package + Hart House Farm Retreat',
  price: early+hhf_addon,
  count: 0,
  start_date: Date.strptime('05-01-2015', '%m-%d-%Y'),
  end_date: Date.strptime('08-31-2015', '%m-%d-%Y'),
)

Package.create(
  key: 'early-bird-standalone_farm_commuter',
  name: 'Early Bird Standalone Package + Hart House Farm Retreat + Commuter Program Package' ,
  price: early+commuter_addon+hhf_addon,
  count: 0,
  start_date: Date.strptime('05-01-2015', '%m-%d-%Y'),
  end_date: Date.strptime('08-31-2015', '%m-%d-%Y'),
)
#STANDALONE
Package.create(
  key: 'standalone',
  name: 'Regular Standalone Package',
  price: normal,
  count: 0,
  start_date: Date.strptime('05-01-2015', '%m-%d-%Y'),
  end_date: Date.strptime('08-31-2015', '%m-%d-%Y'),
)

Package.create(
  key: 'standalone_commuter',
  name: 'Standalone Package + Commuter Program Package',
  price: normal+commuter_addon,
  count: 0,
  start_date: Date.strptime('05-01-2015', '%m-%d-%Y'),
  end_date: Date.strptime('08-31-2015', '%m-%d-%Y'),
)

Package.create(
  key: 'standalone_farm',
  name: 'Standalone Package + Hart House Farm Retreat',
  price: normal+hhf_addon,
  count: 0,
  start_date: Date.strptime('05-01-2015', '%m-%d-%Y'),
  end_date: Date.strptime('08-31-2015', '%m-%d-%Y'),
)

Package.create(
  key: 'standalone_farm_commuter',
  name: 'Standalone Package + Hart House Farm Retreat + Commuter Program Package',
  price: normal+commuter_addon+hhf_addon,
  count: 0,
  start_date: Date.strptime('05-01-2015', '%m-%d-%Y'),
  end_date: Date.strptime('08-31-2015', '%m-%d-%Y'),
)