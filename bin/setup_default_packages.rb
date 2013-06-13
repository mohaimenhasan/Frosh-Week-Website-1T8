#!/usr/bin/env ruby

APP_PATH = File.expand_path('../../config/application',  __FILE__)
require File.expand_path('../../config/boot',  __FILE__)
require APP_PATH
# set Rails.env here if desired
Rails.application.require_environment!

p1 = Package.new ({
  :name => 'test-standalone',
  :description => 'F!rosh Kit Early Bird Standalone',
  :price => 95,
  :count => 0,
  :max => 1,
  :start_date => Date.strptime('05-01-2013', '%m-%d-%Y'),
  :end_date => Date.strptime('09-02-2013', '%m-%d-%Y'),
})
p2 = Package.new ({
  :name => 'test-farm',
  :description => 'F!rosh Kit Early Bird + Hart House Farm Package',
  :price => 120,
  :count => 0,
  :max => 1,
  :start_date => Date.strptime('05-01-2013', '%m-%d-%Y'),
  :end_date => Date.strptime('09-02-2013', '%m-%d-%Y'),
})
p3 = Package.new ({
  :name => 'test-commuter',
  :description => "F!rosh Kit Early Bird + Commuter Program Package",
  :price => 180,
  :count => 0,
  :max => 1,
  :start_date => Date.strptime('05-01-2013', '%m-%d-%Y'),
  :end_date => Date.strptime('09-02-2013', '%m-%d-%Y'),
})
p4 = Package.new ({
  :name => 'test-all',
  :description => "F!rosh Kit Early Bird + Hart House Farm + Commuter Program Package",
  :price => 205,
  :count => 0,
  :max => 1,
  :start_date => Date.strptime('05-01-2013', '%m-%d-%Y'),
  :end_date => Date.strptime('09-02-2013', '%m-%d-%Y'),
})

p1.save
p2.save
p3.save
p4.save