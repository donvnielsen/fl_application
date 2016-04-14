CREATE TABLE IF NOT EXISTS fl_applications
(
  id INTEGER PRIMARY KEY,
  app_cd TEXT NOT NULL unique,
  desc TEXT NOT NULL,
  create_dt TEXT DEFAULT current_timestamp NOT NULL
);
CREATE TABLE IF NOT EXISTS fl_app_def_cols
(
  id INTEGER PRIMARY KEY,
  app_id INTEGER NOT NULL,
  app_variable TEXT NOT NULL,
  create_dt TEXT DEFAULT current_timestamp,
  FOREIGN KEY (app_id) REFERENCES fl_applications (id) ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE INITIALLY DEFERRED,
  unique(app_id,app_variable)
);
CREATE TABLE IF NOT EXISTS fl_processes
(
  id INTEGER PRIMARY KEY,
  process_cd TEXT NOT NULL,
  desc TEXT NOT NULL,
  app_id INTEGER NOT NULL,
  create_dt TEXT DEFAULT current_timestamp NOT NULL,
  start_dt TEXT,
  end_dt TEXT,
  FOREIGN KEY (app_id) REFERENCES fl_applications (id) DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS fl_process_events
(
  id INTEGER PRIMARY KEY,
  desc TEXT NOT NULL,
  process_id INTEGER NOT NULL,
  create_dt TEXT DEFAULT current_timestamp NOT NULL,
  start_dt TEXT,
  end_dt TEXT,
  FOREIGN KEY (process_id) REFERENCES fl_processes (id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
);