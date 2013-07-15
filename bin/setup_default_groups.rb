#!/usr/bin/env ruby

APP_PATH = File.expand_path('../../config/application',  __FILE__)
require File.expand_path('../../config/boot',  __FILE__)
require APP_PATH
# set Rails.env here if desired
Rails.application.require_environment!

Group.new({ symbol: '&alpha;', name: 'Alpha' }).save
Group.new({ symbol: '&beta;', name: 'Beta' }).save
Group.new({ symbol: '&gamma;', name: 'Gamme' }).save
Group.new({ symbol: '&Delta;', name: 'Delta' }).save
Group.new({ symbol: '&theta;', name: 'Theta' }).save
Group.new({ symbol: '&kappa;', name: 'Kappa' }).save
Group.new({ symbol: '&lambda;', name: 'Lambda' }).save
Group.new({ symbol: '&mu;', name: 'Mu' }).save
Group.new({ symbol: '&Nu;', name: 'Nu' }).save
Group.new({ symbol: '&Omicron;', name: 'Omicron' }).save
Group.new({ symbol: '&pi;', name: 'Pi' }).save
Group.new({ symbol: '&rho;', name: 'Rho' }).save
Group.new({ symbol: '&Sigma;', name: 'Sigma' }).save
Group.new({ symbol: '&tau;', name: 'Tau' }).save
Group.new({ symbol: '&phi;', name: 'Phi' }).save
Group.new({ symbol: '&Psi;', name: 'Psi' }).save
Group.new({ symbol: '&Omega;', name: 'Omega' }).save
