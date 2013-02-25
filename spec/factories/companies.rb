# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :company do
    name "MyString"
    phone "MyString"
    website "MyString"
    logo "MyString"
    owner_id 1
  end
end
