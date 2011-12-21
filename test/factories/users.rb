# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
      foreign_id "MyString"
      name "MyString"
    end
end