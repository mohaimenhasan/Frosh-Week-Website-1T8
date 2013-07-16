namespace :db do
  desc "Setup default packages"
  task add_default_packages: [:environment] do
    p1 = Package.new ({
    key: 'test-standalone',
    name: 'F!rosh Kit Early Bird Standalone',
    description: "A standard F!rosh Kit. Includes A, B and C! This kit has tons of awesome stuff
                  that you'll never throw out! Except at the end of F!rosh Week.",
    price: 95,
    count: 0,
    max: 1,
    start_date: Date.strptime('05-01-2013', '%m-%d-%Y'),
    end_date: Date.strptime('09-02-2013', '%m-%d-%Y'),
    })
    p2 = Package.new ({
      key: 'test-farm',
      name: 'F!rosh Kit Early Bird + Hart House Farm Package',
      description: "A standard F!rosh Kit just like above.. except even better! Enjoy camping out at
                    Hart House Farm! You'll get so drunk, you won't even remember spending the extra
                    25 dollars (only if you're over 19 though).",
      price: 120,
      count: 0,
      max: 1,
      start_date: Date.strptime('05-01-2013', '%m-%d-%Y'),
      end_date: Date.strptime('09-02-2013', '%m-%d-%Y'),
    })
    p3 = Package.new ({
      key: 'test-commuter',
      name: "F!rosh Kit Early Bird + Commuter Program Package",
      description: "A standard F!rosh Kit.. with living accomodations! This is super awesome. You get
                    to experience what it would be like to live downtown before enjoying months of
                    tiresome commuting.",
      price: 180,
      count: 0,
      max: 1,
      start_date: Date.strptime('05-01-2013', '%m-%d-%Y'),
      end_date: Date.strptime('09-02-2013', '%m-%d-%Y'),
    })
    p4 = Package.new ({
      key: 'test-all',
      name: "F!rosh Kit Early Bird + Hart House Farm + Commuter Program Package",
      description: "Everything. This is the ultimate kit. You'll get to drink BEvERages, have tons of
                    useless (I mean useful!) crap AND stay downtown before commuting for 3 hours each
                    day! Super fun.",
      price: 205,
      count: 0,
      max: 1,
      start_date: Date.strptime('05-01-2013', '%m-%d-%Y'),
      end_date: Date.strptime('09-02-2013', '%m-%d-%Y'),
    })

    p1.save
    p2.save
    p3.save
    p4.save
  end
end
