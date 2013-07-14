#!/usr/bin/env ruby

APP_PATH = File.expand_path('../../config/application',  __FILE__)
require File.expand_path('../../config/boot',  __FILE__)
require APP_PATH
# set Rails.env here if desired
Rails.application.require_environment!

Group.new({ symbol: '\\u03B1', name: 'Alpha' }).save
Group.new({ symbol: '\\u03B2', name: 'Beta' }).save
Group.new({ symbol: '\\u03B3', name: 'Gamme' }).save
Group.new({ symbol: '\\u0394', name: 'Delta' }).save
Group.new({ symbol: '\\u03B8', name: 'Theta' }).save
Group.new({ symbol: '\\u03BA', name: 'Kappa' }).save
Group.new({ symbol: '\\u03BB', name: 'Lambda' }).save
Group.new({ symbol: '\\u03BC', name: 'Mu' }).save
Group.new({ symbol: '\\u039D', name: 'Ni' }).save
Group.new({ symbol: '\\u03BF', name: 'Omnicron' }).save
Group.new({ symbol: '\\u03C0', name: 'Pi' }).save
Group.new({ symbol: '\\u03C1', name: 'Rho' }).save
Group.new({ symbol: '\\u03A3', name: 'Sigma' }).save
Group.new({ symbol: '\\u03C4', name: 'Tau' }).save
Group.new({ symbol: '\\u03C6', name: 'Phi' }).save
Group.new({ symbol: '\\u03A8', name: 'Psi' }).save
Group.new({ symbol: '\\u03A9', name: 'Omega' }).save
