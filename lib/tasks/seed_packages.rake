namespace :db do

  desc "Seed admins"
  task :seed_packages => :environment do
    Package.delete_all
    PackageItem.delete_all
    ActiveRecord::Base.connection.reset_pk_sequence! Package.table_name
    ActiveRecord::Base.connection.reset_pk_sequence! PackageItem.table_name
    early = 100
    normal = 120
    hhf_addon = 35
    commuter_addon = 85
    early_bird_max = 1
    regular_max = 2
    commuter_max = 1
    hhf_max = 1
    unlimited = -1

#hhf_max = 150, commuter_max=20
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
      max: regular_max,
      left: regular_max,
      start_date: Date.strptime('05-01-2018', '%m-%d-%Y'),
      end_date: Date.strptime('08-31-2018', '%m-%d-%Y'),
    )
    PackageItem.create(
      key: 'farm',
      name: 'Hart House Farm Retreat',
      description: 'A ticket to a camping trip at Hart House Farm, located outside of Caledon on the scenic Niagara Escarpment. Come join us for some fun camping on September 8 and 9 to cap off F!rosh Week!',
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
      description: "Living accommodations! This offer includes a stay at a downtown hostel for four nights (Sunday September 2 - Thursday September 6) including 3 breakfasts, 1 dinner and a chaperone supervision for the entirety of your stay, so you can fully enjoy F!rosh Week's days and nights!",
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

  end

end
