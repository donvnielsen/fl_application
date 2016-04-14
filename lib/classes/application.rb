module FL_Application
  require 'date'

  class Application < ActiveRecord::Base
    self.table_name = 'fl_applications'

    def to_s
      sprintf(
          '[A %5d] %-50s',
          self.id,
          self.desc,
      )
    end

    def to_a
      ary = [self.to_s]
      FL_Application::Process.where(app_id:self.id).each {|p| ary << p.to_a }
      ary.flatten
    end

    def summary
      ary = ['process(es)']
      cumm_run_time = 0
      FL_Application::Process.where(app_id:self.id).each {|p|
        mins = case
                 when p.end_dt.nil? || p.start_dt.nil?
                   0
                 else
                   DateTime.parse(p.end_dt) - DateTime.parse(p.start_dt)
               end
        cumm_run_time += mins
        ary << sprintf(
            '[P %-3d] %-40s %16s %16s-%16s %dm',
            p.id,p.desc,p.create_dt,p.start_dt,p.end_dt,mins.to_i
        )
      }
      ary.insert(0,'[A %-3d] %-60s cumm run time(%dm)',self.id,self.desc,cumm_run_time)
    end

  end
end