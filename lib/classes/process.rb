module FL_Application
  class Process < ActiveRecord::Base
    self.table_name = 'fl_processes'
    def start_dt=(o)
      super(
          case
            when o.is_a?(Time)
              o.strftime('%Y-%m-%d %H:%M:%S')
            when o.is_a?(Date)
              o.strftime('%Y-%m-%d')
            else
              o
          end
      )
    end

    def end_dt=(o)
      super(
          case
            when o.is_a?(Time)
              o.strftime('%Y-%m-%d %H:%M:%S')
            when o.is_a?(Date)
              o.strftime('%Y-%m-%d')
            else
              o
          end
      )
    end

    def to_s
      sprintf(
          '[P %5d] %-50s (%d : %s)',
          self.id,
          self.desc,
          self.app_id,
          FL_Application::Application.where(id:self.app_id).last.desc
      )
    end

    def to_a
      ary = [self.to_s]
      FL_Application::ProcessEvent.where(process_id:self.id).each {|v| ary << (' '*8)+v.to_s}
      ary
    end
  end

end