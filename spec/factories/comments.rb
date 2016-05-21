# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    content "MyText"
    commentable_id 1 
    commentable_type 'Comment'

    factory :recipe_comment do
    	recipe
    end
  end
end
