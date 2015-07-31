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
leedur_name = 'Leedurs Forbidden Forest Adventure'
fweek_name = 'Leedurs n the Chamber of Froshies'
leedur_aka = " (aka Leedur Retreat)"
fweek_aka = " (aka F!week Retreat)"
leedur_max = 100
fweek_max = 70

# BASIC ITEMS FOR SELECTION
HhfPackageItem.create(
  key: 'leedur',
  name: leedur_name + leedur_aka,
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
  name: fweek_name + fweek_aka,
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