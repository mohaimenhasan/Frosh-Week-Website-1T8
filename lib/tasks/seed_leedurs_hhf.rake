namespace :db do

  desc "Seed Leedurs HHF"
  task :seed_leedurs_hhf => :environment do
    HhfPackageItem.delete_all
    HhfPackage.delete_all

    ActiveRecord::Base.connection.reset_pk_sequence! HhfPackage.table_name
    ActiveRecord::Base.connection.reset_pk_sequence! HhfPackageItem.table_name


    leedur = 50
    fweek = 40
    leedur_name = 'Leedurs Hart House Farm Retreat w/ Transportation'
    fweek_name = 'Leedurs Hart House Farm Retreat w/out Transportation'

    leedur_max = 60
    fweek_max = 35

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
      start_date: Date.strptime('05-01-2018', '%m-%d-%Y'),
      end_date: Date.strptime('09-09-2018', '%m-%d-%Y'),
    )


    # All Combo
    HhfPackage.create(
      key: 'leedur',
      name: leedur_name,
      price: leedur,
    )


  end

end
