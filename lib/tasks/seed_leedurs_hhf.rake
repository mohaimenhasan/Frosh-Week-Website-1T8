namespace :db do

  desc "Seed Leedurs HHF"
  task :seed_leedurs_hhf => :environment do
    HhfPackageItem.delete_all
    HhfPackage.delete_all

    ActiveRecord::Base.connection.reset_pk_sequence! HhfPackage.table_name
    ActiveRecord::Base.connection.reset_pk_sequence! HhfPackageItem.table_name


    leedur = 50
    leedur_max = 60
    leedur_name = 'Leedurs Hart House Farm Retreat w/Transport'

    leedurnobus = 40
    leedurnobus_max = 35
    leedurnobus_name = 'Leedurs Hart House Farm Retreat w/out Transport'


    # BASIC ITEMS FOR SELECTION
    HhfPackageItem.create(
      key: 'leedur',
      name: leedur_name ,
      description: '',
      price: leedur,
      count: 0,
      max: leedur_max,
      left: leedur_max,
      start_date: Date.strptime('05-01-2018', '%m-%d-%Y'),
      end_date: Date.strptime('07-20-2018', '%m-%d-%Y'),
    )

    HhfPackageItem.create(
      key: 'leedurnobus',
      name: leedurnobus_name ,
      description: '',
      price: leedurnobus,
      count: 0,
      max: leedurnobus_max,
      left: leedurnobus_max,
      start_date: Date.strptime('05-01-2018', '%m-%d-%Y'),
      end_date: Date.strptime('07-20-2018', '%m-%d-%Y'),
    )

    # All Combo
    HhfPackage.create(
      key: 'leedur',
      name: leedur_name,
      price: leedur,
    )

    HhfPackage.create(
      key: 'leedurnobus',
      name: leedurnobus_name,
      price: leedurnobus,
    )


  end

end
