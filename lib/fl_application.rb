module FL_Application
  require 'active_record'
  require_relative '../lib/classes/application'
  require_relative '../lib/classes/app_def_col'
  require_relative '../lib/classes/process'
  require_relative '../lib/classes/event'

  ROOTDIR = __dir__
  # because sqlite cannot handle multiple statements in one file, each
  # statement is split (using ;) into an array of statements, where
  # the array should be iterated over and each submitted separately.
  DB_DDL = File.read(
      File.join(FL_Application::ROOTDIR,'sql','db_ddl.sql')
  ).split(';').map{|sql| sql.strip.nil? ? nil : sql.strip<<';'}

  def FL_Application.build_tables(o = {db_name:nil,delete_db:false})
    # dbname must be provided
    File.delete(o[:db_name]) if File.exist?(o[:db_name]) && o[:delete_db]
    conn = ActiveRecord::Base.establish_connection(adapter:'sqlite3',database:o[:db_name])
    FL_Application::DB_DDL.each {|sql| conn.connection.execute(sql) unless sql.strip.size == 0 }
    conn.connection.execute('PRAGMA foreign_keys = on;')
  end

end