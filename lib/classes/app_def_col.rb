class AppDefCol
end

module FL_Application
  class AppDefCol < ActiveRecord::Base
    self.table_name = 'fl_app_def_cols'
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

  end
end