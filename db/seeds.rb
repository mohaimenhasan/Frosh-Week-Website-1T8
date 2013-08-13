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

Group.create(symbol: '&alpha;', name: 'Alpha')
Group.create(symbol: '&beta;', name: 'Beta')
Group.create(symbol: '&gamma;', name: 'Gamma')
Group.create(symbol: '&Delta;', name: 'Delta')
Group.create(symbol: '&theta;', name: 'Theta')
Group.create(symbol: '&kappa;', name: 'Kappa')
Group.create(symbol: '&lambda;', name: 'Lambda')
Group.create(symbol: '&mu;', name: 'Mu')
Group.create(symbol: '&Nu;', name: 'Ni')
Group.create(symbol: '&Omicron;', name: 'Omicron')
Group.create(symbol: '&pi;', name: 'Pi')
Group.create(symbol: '&rho;', name: 'Rho')
Group.create(symbol: '&Sigma;', name: 'Sigma')
Group.create(symbol: '&tau;', name: 'Tau')
Group.create(symbol: '&phi;', name: 'Phi')
Group.create(symbol: '&Psi;', name: 'Psi')
Group.create(symbol: '&Omega;', name: 'Omega')

Group.find_each do |g|
  g.facebook_link = "http://facebook.com/groups/#{g.name.downcase}.1t3"
  g.facebook_link = "http://facebook.com/groups/1t3.#{g.name.downcase}" if g.name == 'Delta'
  g.save!
end

Package.create(
  key: 'early-bird-standalone',
  name: 'F!rosh Kit Early Bird Standalone Package',
  description: 'A standard F!rosh Kit. Includes entrance to all events (like a parade!), a collection of cool things (like a hard hat!), and lots more! This kit has tons of awesome stuff!',
  price: 100,
  count: 0,
  max: 1,
  start_date: Date.strptime('05-01-2013', '%m-%d-%Y'),
  end_date: Date.strptime('08-21-2013', '%m-%d-%Y'),
)
Package.create(
  key: 'early-bird-with-farm',
  name: 'F!rosh Kit Early Bird + Hart House Farm Package',
  description: 'A standard F!rosh Kit just like above... except even better! This package includes a ticket to a camping trip at Hart House Farm, located outside of Caledon on the scenic Niagara Escarpment. Come join us for some fun camping on September 7 and 8 to cap off F!rosh Week!',
  price: 130,
  count: 0,
  max: 1,
  start_date: Date.strptime('05-01-2013', '%m-%d-%Y'),
  end_date: Date.strptime('08-21-2013', '%m-%d-%Y'),
)
Package.create(
  key: 'early-bird-with-commuter',
  name: 'F!rosh Kit Early Bird + Commuter Program Package',
  description: "A standard F!rosh Kit... with living accommodations! This offer includes room and board at a downtown hostel for four nights so you can fully enjoy F!rosh Week's days and nights.",
  price: 185,
  count: 0,
  max: 1,
  start_date: Date.strptime('05-01-2013', '%m-%d-%Y'),
  end_date: Date.strptime('08-21-2013', '%m-%d-%Y'),
)
Package.create(
  key: 'early-bird-all',
  name: 'F!rosh Kit Early Bird + Hart House Farm + Commuter Program Package',
  description: 'This is for the F!rosh that wants to have the ultimate F!rosh Week experience. You get a standard F!rosh kit, accommodations throughout the week, and a ticket to the weekend Hart House Farm camping trip. Super fun!',
  price: 215,
  count: 0,
  max: 1,
  start_date: Date.strptime('05-01-2013', '%m-%d-%Y'),
  end_date: Date.strptime('08-21-2013', '%m-%d-%Y'),
)

Package.create(
  key: 'standalone',
  name: 'F!rosh Kit Standalone Package',
  description: 'A standard F!rosh Kit. Includes entrance to all events (like a parade!), a collection of cool things (like a hard hat!), and lots more! This kit has tons of awesome stuff!',
  price: 120,
  count: 0,
  max: 1,
  start_date: Date.strptime('08-22-2013', '%m-%d-%Y'),
  end_date: Date.strptime('09-02-2013', '%m-%d-%Y'),
)
Package.create(
  key: 'farm',
  name: 'F!rosh Kit + Hart House Farm Package',
  description: 'A standard F!rosh Kit just like above... except even better! This package includes a ticket to a camping trip at Hart House Farm, located outside of Caledon on the scenic Niagara Escarpment. Come join us for some fun camping on September 7 and 8 to cap off F!rosh Week!',
  price: 150,
  count: 0,
  max: 1,
  start_date: Date.strptime('08-22-2013', '%m-%d-%Y'),
  end_date: Date.strptime('09-02-2013', '%m-%d-%Y'),
)
Package.create(
  key: 'commuter',
  name: 'F!rosh Kit + Commuter Program Package',
  description: "A standard F!rosh Kit... with living accommodations! This offer includes room and board at a downtown hostel for four nights so you can fully enjoy F!rosh Week's days and nights.",
  price: 205,
  count: 0,
  max: 1,
  start_date: Date.strptime('08-22-2013', '%m-%d-%Y'),
  end_date: Date.strptime('09-02-2013', '%m-%d-%Y'),
)
Package.create(
  key: 'all',
  name: 'F!rosh Kit + Hart House Farm + Commuter Program Package',
  description: 'This is for the F!rosh that wants to have the ultimate F!rosh Week experience. You get a standard F!rosh kit, accommodations throughout the week, and a ticket to the weekend Hart House Farm camping trip. Super fun!',
  price: 235,
  count: 0,
  max: 1,
  start_date: Date.strptime('08-22-2013', '%m-%d-%Y'),
  end_date: Date.strptime('09-02-2013', '%m-%d-%Y'),
)
