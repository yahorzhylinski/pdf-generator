require "rails_helper"

RSpec.describe UserReport, type: :model do

  before(:each) do
    User.delete_all
    UserReport.delete_all
  end

  it { should belong_to :report }
  it { should belong_to :user }

  it { should validate_presence_of :user }
  it { should validate_presence_of :campaign_id }

  it { should validate_length_of :comment }

  # it { should validate_inclusion_of :status }

  it 'should have and don"t have report' do 
    user_report = FactoryGirl.build(:user_report)
    user_report.user = FactoryGirl.build(:user)
    user_report.report = FactoryGirl.build(:report)

    user_report.report = nil
    user_report.should be_valid
  end

  it 'should have only statuses' do
    user_report = FactoryGirl.build(:user_report)
    user_report.user = FactoryGirl.build(:user)
    user_report.report = FactoryGirl.build(:report)
    
    user_report.status = :pending
    user_report.should be_valid

    user_report.status = :error
    user_report.should be_valid

    user_report.status = :generated
    user_report.should be_valid
  end

end