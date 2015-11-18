FactoryGirl.define do
  factory :user_report, class: "UserReport" do
    campaign_id  Faker::Number.number(5)
  end
end