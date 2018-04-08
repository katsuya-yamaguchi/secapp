FactoryGirl.define do
  factory :user do
    id "1"
    email "admin@gmail.com"
    password "1234567"
    after(:build){|u| u.skip_confirmation_notification! }
    after(:create){|u| u.confirm}
  end
end
