FactoryGirl.define do

  factory :user do
    name  {Faker::Name.name}
    email {Faker::Internet.email}
    password "12345678"
    password_confirmation "12345678"
    role 0
  end

  factory :supervisor, class: User do
    name  "Ly Xuan Sang"
    email "lyxuansang1991@gmail.com"
    password "12345678"
    password_confirmation "12345678"
    role 1
  end
end
