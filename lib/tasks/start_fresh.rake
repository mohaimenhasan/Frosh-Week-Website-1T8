namespace :db do
  desc "Start fresh database"
  task start_fresh: [:environment] do
  	Rake::Task["db:drop"].invoke
  	Rake::Task["db:create"].invoke
  	Rake::Task["db:migrate"].invoke

  	Rake::Task["db:add_default_groups"].invoke
  	Rake::Task["db:add_default_packages"].invoke
  end
end
