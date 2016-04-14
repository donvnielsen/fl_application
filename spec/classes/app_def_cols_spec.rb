module FL_Application
  require 'spec_helper'

  describe 'app def columns' do
    before(:all) do
      Application.create!(app_cd:'col01',desc:'test application col def append')
    end
    it 'should require an app id' do
      expect{AppDefCol.create!()}.to raise_error(ActiveRecord::StatementInvalid)
      expect{AppDefCol.create!(app_id:'xxx')}.to raise_error(ActiveRecord::StatementInvalid)
    end
    it 'should require a variable name' do
      expect{AppDefCol.create!(app_variable:'var_01')}.to raise_error(ActiveRecord::StatementInvalid)
      expect{AppDefCol.create!(
          app_id:Application.last.id,
          app_variable:'var_01')}.to_not raise_error
    end
    # it 'should initialize format col def -1' do
    #   expect(AppDefCol.last.format_col_id).to eq(-1)
    # end
    it 'should set the create date' do
      expect(AppDefCol.last.create_dt.nil?).to be_falsey
    end
    it 'should prevent a duplicate entry' do
      expect{AppDefCol.create!(
          app_id:Application.last.id,
          app_variable:'var_01')
      }.to raise_error(ActiveRecord::RecordNotUnique)
    end
  end
end
