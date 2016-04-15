require 'rspec'
require 'simplecov'
# SimpleCov.start

# require 'active_record'
require_relative '../lib/fl_application'

require 'pp'

module FL_Application
  DB_NAME = 'db/test_application.db'
  File.delete(DB_NAME) if File.exist?(DB_NAME)
  conn = ActiveRecord::Base.establish_connection(adapter:'sqlite3',database:DB_NAME)
  FL_Application::build_tables(conn)
  conn.connection.execute('PRAGMA foreign_keys = on;')
end

