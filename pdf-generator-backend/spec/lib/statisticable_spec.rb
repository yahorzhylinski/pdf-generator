require "rails_helper"
require "#{Rails.root}/lib/platform161_api/models/statisticable.rb"

class TestClass
end

RSpec.describe Platform161Api::Models::Statisticable, type: :model do

  before(:each) do
    @value = TestClass.new
    @value.extend(Platform161Api::Models::Statisticable)
  end

  it 'should return 0.0 for all values if data is nil' do 
    @value.get_statistic! nil
    @value.media_spent.should equal_to(0.0)
    @value.media_budget.should equal_to(0.0)  
    @value.media_spent.should equal_to(0.0)   
    @value.impressions.should equal_to(0.0)   
    @value.clicks.should equal_to(0.0)        
    @value.ctr.should equal_to(0.0)           
    @value.conversions.should equal_to(0.0)
  end

  it 'should return 0.0 for all values if data is empty' do 
    @value.get_statistic! []
    @value.media_spent.should equal_to(0.0)
    @value.media_budget.should equal_to(0.0)  
    @value.media_spent.should equal_to(0.0)   
    @value.impressions.should equal_to(0.0)   
    @value.clicks.should equal_to(0.0)        
    @value.ctr.should equal_to(0.0)           
    @value.conversions.should equal_to(0.0)
  end

  it 'should calculate correctly' do
    @value.get_statistic! [{"media_budget" => 1.0},{"media_budget" => 2.2}]
    @value.media_budget.should equal_to(3.2)
  end


  it 'should calculate correctly' do
    @value.get_statistic! [{"impressions" => 1.0},{"impressions" => 2.2}]
    @value.impressions.should equal_to(3.2)
  end


  it 'should calculate correctly' do
    @value.get_statistic! [{"clicks" => 1.0},{"clicks" => 2.2}]
    @value.clicks.should equal_to(3.2)
  end


  it 'should calculate correctly' do
    @value.get_statistic! [{"ctr" => 1.0},{"ctr" => 2.2}]
    @value.ctr.should equal_to(3.2)
  end


  it 'should calculate correctly' do
    @value.get_statistic! [{"conversions" => 1.0},{"conversions" => 2.2}]
    @value.conversions.should equal_to(3.2)
  end


  it 'should calculate correctly' do
    @value.get_statistic! [{"impressions" => 1.0, "gross_revenues" => 2},{"impressions" => 2.2, "gross_revenues" => 1}]
    @value.ecpm.should equal_to(0.0009375)
  end
end