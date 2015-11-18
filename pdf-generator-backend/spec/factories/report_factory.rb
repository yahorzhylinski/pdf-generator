FactoryGirl.define do
  factory :report, class: "Report" do
    file_name Faker::Internet.password(100)
  end
end