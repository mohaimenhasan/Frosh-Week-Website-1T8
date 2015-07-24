# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

HhfPackageItem.delete_all
HhfPackage.delete_all

ActiveRecord::Base.connection.reset_pk_sequence! HhfPackage.table_name
ActiveRecord::Base.connection.reset_pk_sequence! HhfPackageItem.table_name


leedur = 40
fweek = 30
leedur_name = 'Leedur ForbiddenForest Adventure'
fweek_name = 'Leedurs n the Chamber of Froshies'
leedur_max = 200
fweek_max = 50

# BASIC ITEMS FOR SELECTION
HhfPackageItem.create(
  key: 'leedur',
  name: leedur_name,
  description: 'We, leedurs, be the first to explore the Forbidden Forest. Fight spiders, dementors n stuff',
  price: leedur,
  count: 0,
  max: leedur_max,
  left: leedur_max,
  start_date: Date.strptime('05-01-2015', '%m-%d-%Y'),
  end_date: Date.strptime('08-31-2015', '%m-%d-%Y'),
)

HhfPackageItem.create(
  key: 'fweek',
  name: fweek_name,
  description: 'Having fun with frosh n stuff',
  price: fweek,
  count: 0,
  max: fweek_max,
  left: fweek_max, 
  start_date: Date.strptime('05-01-2015', '%m-%d-%Y'),
  end_date: Date.strptime('08-31-2015', '%m-%d-%Y'),
)

# All Combo
HhfPackage.create(
  key: 'leedur',
  name: leedur_name,
  price: leedur
)
HhfPackage.create(
  key: 'fweek',
  name: fweek_name,
  price: fweek
)
HhfPackage.create(
  key: 'leedur_fweek',
  name: leedur_name + ' + ' + fweek_name,
  price: leedur + fweek
)