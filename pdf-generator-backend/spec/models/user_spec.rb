require "rails_helper"

RSpec.describe User, type: :model do

  before(:each) do
    User.delete_all
  end

  it { should validate_presence_of(:username) }
  it { should validate_length_of(:username) }
  # it { should validate_uniqueness_of(:username) }

  it { should have_many :user_reports }
  it { should have_many :reports }

  it 'should validate username and existing email' do 
    user = FactoryGirl.create(:user)
    user2 = FactoryGirl.build(:user)

    user.email = "email2@email.com"
    user.username = user2.email

    user.should_not be_valid
  end

end