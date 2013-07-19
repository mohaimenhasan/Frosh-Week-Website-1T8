namespace :db do
  desc "Setup default packages"
  task add_default_packages: [:environment] do
    p1 = Package.new ({
    key: 'early-bird-standalone',
    name: 'F!rosh Kit Early Bird Standalone Package',
    description: 'A standard F!rosh Kit. Includes entrance to all events (like a parade!), a 
                  collection of cool things (like a hard hat!), and lots more! This kit has tons 
                  of awesome stuff!',
    price: 100,
    count: 0,
    max: 1,
    start_date: Date.strptime('05-01-2013', '%m-%d-%Y'),
    end_date: Date.strptime('08-15-2013', '%m-%d-%Y'),
    })
    p2 = Package.new ({
      key: 'early-bird-with-farm',
      name: 'F!rosh Kit Early Bird + Hart House Farm Package',
      description: 'A standard F!rosh Kit just like above... except even better! This package 
                    includes a ticket to a camping trip at Hart House Farm, located outside of 
                    Caledon on the scenic Niagra Escarpment. Come join us for some fun camping 
                    on September 7 and 8 to cap off F!rosh Week!',
      price: 130,
      count: 0,
      max: 1,
      start_date: Date.strptime('05-01-2013', '%m-%d-%Y'),
      end_date: Date.strptime('08-15-2013', '%m-%d-%Y'),
    })
    p3 = Package.new ({
      key: 'early-bird-with-commuter',
      name: 'F!rosh Kit Early Bird + Commuter Program Package',
      description: "A standard F!rosh Kit... with living accommodations! This offer includes room 
                    and board at a downtown hostel for four nights so you can fully enjoy 
                    F!rosh Week's days and nights.",
      price: 185,
      count: 0,
      max: 1,
      start_date: Date.strptime('05-01-2013', '%m-%d-%Y'),
      end_date: Date.strptime('08-15-2013', '%m-%d-%Y'),
    })
    p4 = Package.new ({
      key: 'early-bird-all',
      name: 'F!rosh Kit Early Bird + Hart House Farm + Commuter Program Package',
      description: 'This is for the F!rosh that wants to have the ultimate F!rosh Week experience.
                    You get a standard F!rosh kit, accommodations throughout the week, and a 
                    ticket to the weekend Hart House Farm camping trip. Super fun!',
      price: 215,
      count: 0,
      max: 1,
      start_date: Date.strptime('05-01-2013', '%m-%d-%Y'),
      end_date: Date.strptime('08-15-2013', '%m-%d-%Y'),
    })

    p1.save
    p2.save
    p3.save
    p4.save
  end
end
