# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :issue do
    title "MyString"
    details "MyText"
    site nil
    user nil
    company_id 1
  end
end
