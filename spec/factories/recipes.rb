# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :recipe do
  	name  'Lasagna'
    steps ['cooking stes']
    ingredients 'food items'
    cuisine 'italian'
  end
end
