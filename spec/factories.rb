FactoryGirl.define do
  factory :relation do
  end

  factory :role do
    sequence(:name) {|n| "Rolle#{n}" }
  end
  factory :task do
    sequence(:task_id) {|n| n}
    sequence(:name) {|n| "Task#{n}" }
    sod false
    weight 0
  end
end
