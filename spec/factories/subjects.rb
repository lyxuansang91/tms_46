FactoryGirl.define do
  factory :subject do
    name {Faker::Lorem.word}
    instruction {Faker::Lorem.paragraph}
  end
end
