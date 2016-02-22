FactoryGirl.define do
  factory :task do |task|
    name {Faker::Lorem.word}
  end
end
