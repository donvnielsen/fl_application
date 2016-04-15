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

  def FL_Application.build_tables(db)
    raise RuntimeError,'db class must be ActiveRecord::ConnectionAdapters::ConnectionPool' unless db.is_a?(ActiveRecord::ConnectionAdapters::ConnectionPool)
    unless ActiveRecord::Base.connection.tables.include?(Application.table_name)
      FL_Application::DB_DDL.each {|sql| db.connection.execute(sql) unless sql.strip.size == 0 }
      db.connection.execute('PRAGMA foreign_keys = on;')
    end
  end

end