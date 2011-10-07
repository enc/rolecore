# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :relation do
      parent_id 1
      child_id 1
      child_type "MyString"
    end
end
