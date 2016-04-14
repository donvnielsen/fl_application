module FL_Application
  require 'active_record'
  require_relative '../lib/classes/application'
  require_relative '../lib/classes/app_def_col'
  require_relative '../lib/classes/process'
  require_relative '../lib/classes/event'

  DB_DDL = 'lib/sql/db_ddl.sql'

  def FL_Application.build_tables(o = {db_name:nil,delete_db:false})
    # dbname must be provided
    File.delete(o[:db_name]) if File.exist?(o[:db_name]) && o[:delete_db]
    conn = ActiveRecord::Base.establish_connection(adapter:'sqlite3',database:o[:db_name])
    sqls = File.read(DDL_NAME).split(';')
    sqls.each {|sql| conn.connection.execute(sql<<';') unless sql.strip.size == 0 }
    conn.connection.execute('PRAGMA foreign_keys = on;')
  end

end