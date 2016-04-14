module FL_Application
  require 'spec_helper'

  describe 'processes' do
    before(:all) do
      Application.create!(app_cd:'test_prc',desc:'test process attributes')
    end

    it 'should link to a valid app id' do
      expect{Process.create!()}.to raise_error(ActiveRecord::StatementInvalid)
      expect{Process.create!(app_id:Application.last.id,process_cd:'pcd',desc:'valid app code')}.to_not raise_error
    end
    it 'should require a process code' do
      expect{Process.create!(app_id:'xxx',desc:'invalid app code')}.to raise_error(ActiveRecord::StatementInvalid)
      expect{Process.create!(app_id:Application.last.id,process_cd:'pcd',desc:'valid app code')}.to_not raise_error
    end
    it 'should require a description' do
      expect{Process.create!(app_id:Application.last.id,process_cd:'pcd')}.to raise_error(ActiveRecord::StatementInvalid)
      expect{Process.create!(app_id:Application.last.id,desc:'valid app code',process_cd:'pcd')}.to_not raise_error
    end
    it 'should set the create date' do
      Process.create!(app_id:Application.last.id,desc:'test default create date',process_cd:'pcd')
      expect(Process.last.create_dt.nil?).to be_falsey
    end
    it 'should permit a start date' do
      tme = Time.now
      Process.create!(app_id:Application.last.id,desc:'set start date',process_cd:'pcd',start_dt:tme)
      expect(Process.last.start_dt).to eq(tme.strftime('%Y-%m-%d %H:%M:%S'))
    end
    it 'should permit an end date' do
      dte = Date.today
      Process.create!(app_id:Application.last.id,desc:'set end date',process_cd:'pcd',end_dt:dte)
      expect(Process.last.end_dt).to eq(dte.strftime('%Y-%m-%d'))
    end
  end

  describe 'summary' do
    before(:all) do
      Application.create!(app_cd:'sumproc',desc:'test process summary')
      Process.create!(app_id:Application.last.id,desc:'summary process',start_dt:Time.now,process_cd:'pcd')
      ProcessEvent.create!(process_id:Process.last.id,desc:'evt 01 First event')
      ProcessEvent.create!(process_id:Process.last.id,desc:'evt 02 Second event')
      ProcessEvent.create!(process_id:Process.last.id,desc:'evt 03 Third event')
      ProcessEvent.create!(process_id:Process.last.id,desc:'evt 04 Fourth event')
    end

    it 'should create a summary list' do
      ary = Process.last.to_a
      expect(ary.is_a?(Array)).to be_truthy
      pp ary
    end
  end
end