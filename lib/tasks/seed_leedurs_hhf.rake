namespace :db do

  desc "Seed Leedurs HHF"
  task :seed_leedurs_hhf => :environment do
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
      start_date: Date.strptime('05-01-2018', '%m-%d-%Y'),
      end_date: Date.strptime('07-15-2018', '%m-%d-%Y'),
    )

    HhfPackageItem.create(
      key: 'fweek',
      name: fweek_name ,
      description: '',
      price: fweek,
      count: 0,
      max: fweek_max,
      left: fweek_max, 
      start_date: Date.strptime('05-01-2018', '%m-%d-%Y'),
      end_date: Date.strptime('09-09-2018', '%m-%d-%Y'),
    )

    # All Combo
    HhfPackage.create(
      key: 'leedur',
      name: leedur_name,
      price: leedur,
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
  end

end
