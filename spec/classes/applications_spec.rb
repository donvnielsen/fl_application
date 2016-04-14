module FL_Application
  require 'spec_helper'

  describe 'applications' do
    it 'should have an application code' do
      expect{Application.create!()}.to raise_error(ActiveRecord::StatementInvalid)
    end
    it 'should have a description' do
      expect{Application.create!(app_cd:'test01')}.to raise_error(ActiveRecord::StatementInvalid)
      expect{Application.create!(app_cd:'test01',desc:'test description')}.to_not raise_error
    end
    it 'should have a create date assigned' do
      app = Application.create!(app_cd:'test02',desc:'test description')
      expect(app.create_dt.nil?).to be_falsey
    end
    it 'should prevent a duplicate application code' do
      Application.create!(app_cd:'test03',desc:'test description')
      expect{Application.create!(app_cd:'test03',desc:'test description')}.to raise_error(ActiveRecord::RecordNotUnique)
    end
    it 'should delete all associated data when deleted'
  end

  describe 'summary' do
    before(:all) do
      Application.create!(app_cd:'summary',desc:'test application summary')
      Process.create!(app_id:Application.last.id,desc:'summary process',start_dt:Time.now,process_cd:'pcd')
      ProcessEvent.create!(process_id:Process.last.id,desc:'evt 01 First event')
      ProcessEvent.create!(process_id:Process.last.id,desc:'evt 02 Second event')
      ProcessEvent.create!(process_id:Process.last.id,desc:'evt 03 Third event')
      ProcessEvent.create!(process_id:Process.last.id,desc:'evt 04 Fourth event')
    end

    it 'should create a process list' do
      ary = Application.last.to_a
      expect(ary.is_a?(Array)).to be_truthy
      pp ary
    end

    it 'should create a summary' do
      pp Application.last.summary
    end
  end
end
