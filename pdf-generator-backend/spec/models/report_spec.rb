require "rails_helper"

RSpec.describe Report, type: :model do

  before(:each) do
    User.delete_all
    UserReport.delete_all
    Report.delete_all
  end


  it { should have_many :user_reports }
  it { should have_many :users }
  it { should validate_length_of :file_name }

  it 'should validate file name uniquenes' do 
    report = FactoryGirl.build(:report)
    report2 = FactoryGirl.build(:report)
    report2.file_name = report.file_name
    # report2.should_not be_valid
  end

  it 'should have at least one user_report' do 
    report = FactoryGirl.build(:report)
    report.user_reports = []
    report.should_not be_valid
  end

end