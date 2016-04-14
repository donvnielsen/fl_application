module FL_Application
  require 'spec_helper'

  describe 'events' do
    before(:all) do
      Application.create!(app_cd:'test_events',desc:'test process attributes')
      Process.create!(app_id:Application.last.id,desc:'test events',process_cd:'pcd')
    end
    it 'should require a process id' do
      expect{ProcessEvent.create!()}.to raise_error(ActiveRecord::StatementInvalid)
      expect{ProcessEvent.create!(process_id:Process.last.id,desc:'pass process id')}.to_not raise_error
    end
    it 'should require a description' do
      expect{ProcessEvent.create!(process_id:Process.last.id)}.to raise_error(ActiveRecord::StatementInvalid)
      expect{ProcessEvent.create!(process_id:Process.last.id,desc:'pass process id')}.to_not raise_error
    end
    it 'should have a default create date' do
      ProcessEvent.create!(process_id:Process.last.id,desc:'default create date')
      expect(ProcessEvent.last.create_dt.nil?).to be_falsey
    end
    it 'should permit a create date' do
      tme = Time.now
      ProcessEvent.create!(process_id:Process.last.id,desc:'set create date',create_dt:tme)
      expect(ProcessEvent.last.create_dt).to eq(tme.strftime('%Y-%m-%d %H:%M:%S'))
    end
    it 'should delete all events when process is deleted' do
      x = Process.last.id
      Process.destroy(x)
      expect(ProcessEvent.all.where(process_id:x).count).to eq(0)
    end
  end
end
