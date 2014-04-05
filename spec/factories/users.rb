# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    provider "MyString"
    uid "MyString"
    name "MyString"
    image_url "MyString"
    email "MyString"
    access_token "MyString"
  end
end
