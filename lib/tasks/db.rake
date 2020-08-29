#  ------------------------------------
#  --- RUBYNETTI DUMP POWER -----------
#  ------------------------------------

# Queste azioni rake permettono di importare il db da linea di comando.
# Esempi di uso:
# - rake db:import_from_staging
# - rake db:import_from_sql (importa sql da dumps/db-staging.sql)

namespace :db do

  desc 'Dump db from staging and copy inside locale'
  # esempio: rake db:import_from_staging
  task import_from_staging: :environment do
    Rake::Task['db:dump_and_download'].invoke
    Rake::Task['db:substitute'].invoke(AmicoDb.configuration.folder_dump)
  end

  # esempio: rake db:import_from_sql
  desc 'Dump db di staging'
  task import_from_sql: :environment do
    Rake::Task['db:substitute'].invoke(AmicoDb.configuration.folder_dump)
  end

  desc 'Dump database and import requested dump'
  task  :substitute, [:dump_path] => :environment do |_task, args|
    Rake::Task['db:drop'].invoke
    Rake::Task['db:create'].invoke
    Rake::Task['db:environment:set'].invoke
    Rake::Task['db:import'].invoke("#{args.dump_path.sub('/','')}")
  end

  desc 'Download from staging sql dump of db'
  task download: :environment do
    AmicoDb::Download.new.call
  end

  desc 'Import requested dump'
  task :import, [:dump_path] => :environment do |_task, args|
    db_name = AmicoDb.configuration.db_dev_dbname
    user = AmicoDb.configuration.db_dev_username
    system("pv #{args.dump_path} | mysql -h db -u #{user} -p #{db_name}")
  end

  desc 'Dump and download from staging db'
  task dump_and_download: :environment do
    Rake::Task['db:dump'].invoke
    Rake::Task['db:download'].invoke
  end

  desc 'Dump db staging'
  task dump: :environment do
    AmicoDb::Dump.new.call
  end
end
