# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :approval do
    role_id 1
    rfc_id 1
    closed false
  end
end
