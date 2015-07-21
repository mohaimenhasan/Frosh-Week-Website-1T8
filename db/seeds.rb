# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

HhfPackage.delete_all

ActiveRecord::Base.connection.reset_pk_sequence! HhfPackage.table_name



leedur = 40
fweek = 30

leedur_max = 200
fweek_max = 50

# BASIC ITEMS FOR SELECTION
HhfPackage.create(
  key: 'leedur',
  name: 'Leedur ForbiddenForest Adventure',
  description: 'We, leedurs, be the first to explore the Forbidden Forest. Fight spiders, dementors n stuff',
  price: leedur,
  count: 0,
  max: leedur_max,
  left: leedur_max,
  start_date: Date.strptime('05-01-2015', '%m-%d-%Y'),
  end_date: Date.strptime('08-31-2015', '%m-%d-%Y'),
)

HhfPackage.create(
  key: 'fweek',
  name: 'Leedurs n the Chamber of frosh',
  description: 'Having fun with frosh n stuff',
  price: fweek,
  count: 0,
  max: fweek_max,
  left: fweek_max, 
  start_date: Date.strptime('05-01-2015', '%m-%d-%Y'),
  end_date: Date.strptime('08-31-2015', '%m-%d-%Y'),
)
