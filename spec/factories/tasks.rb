FactoryGirl.define do
  factory :task do
    title "MyString"
    description "MyString"
    done false
    deadline "2017-07-29 23:16:01"
    user nil
  end
end
