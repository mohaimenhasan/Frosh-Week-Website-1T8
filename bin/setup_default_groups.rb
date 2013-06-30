#!/usr/bin/env ruby

APP_PATH = File.expand_path('../../config/application',  __FILE__)
require File.expand_path('../../config/boot',  __FILE__)
require APP_PATH
# set Rails.env here if desired
Rails.application.require_environment!

Group.new(name: 'Alpha').save
Group.new(name: 'Beta').save
Group.new(name: 'Gamme').save
Group.new(name: 'Delta').save
Group.new(name: 'Theta').save
Group.new(name: 'Kappa').save
Group.new(name: 'Lambda').save
Group.new(name: 'Mu').save
Group.new(name: 'Ni').save
Group.new(name: 'Omnicron').save
Group.new(name: 'Pi').save
Group.new(name: 'Rho').save
Group.new(name: 'Sigma').save
Group.new(name: 'Tau').save
Group.new(name: 'Phi').save
Group.new(name: 'Psi').save
Group.new(name: 'Omega').save
