FactoryGirl.define do
  factory :user do
    name    "Larry Ritchie"
    email   "larry@example.com"
    password "foobar"
    password_confirmation "foobar"
  end
end