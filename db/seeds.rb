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
fweek = 35
leedur_name = 'Leedurs Hart House Farm Retreat'
fweek_name = 'Froshies x Leedus Hart House Farm Retreat'

leedur_max = 50
fweek_max = 40

leedurbus = 46
fweekbus = 30
# BASIC ITEMS FOR SELECTION
HhfPackageItem.create(
  key: 'leedur',
  name: leedur_name ,
  description: '',
  price: leedur,
  count: 0,
  max: leedur_max,
  left: leedur_max,
  start_date: Date.strptime('05-01-2016', '%m-%d-%Y'),
  end_date: Date.strptime('07-15-2016', '%m-%d-%Y'),
)
=begin
HhfPackageItem.create(
  key: 'fweek',
  name: fweek_name ,
  description: '',
  price: fweek,
  count: 0,
  max: fweek_max,
  left: fweek_max, 
  start_date: Date.strptime('05-01-2016', '%m-%d-%Y'),
  end_date: Date.strptime('09-09-2016', '%m-%d-%Y'),
)
=end
# All Combo
HhfPackage.create(
  key: 'leedur',
  name: leedur_name,
  price: leedur,
)
=begin
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
=end