module FL_Application
  class ProcessEvent < ActiveRecord::Base
    self.table_name = 'fl_process_events'
    def create_dt=(o)
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
      sprintf('[E %5d] %-50s %-25s',self.id,self.desc,self.create_dt)
    end
  end
end