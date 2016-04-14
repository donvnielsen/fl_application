require 'rspec'
require 'simplecov'
# SimpleCov.start

# require 'active_record'
require_relative '../lib/fl_application'

require 'pp'

module FL_Application
  DB_NAME = 'db/test_application.db'
  FL_Application::build_tables({db_name:DB_NAME,delete_db:true})
  conn = ActiveRecord::Base.establish_connection(adapter:'sqlite3',database:DB_NAME)
  conn.connection.execute('PRAGMA foreign_keys = on;')
end

