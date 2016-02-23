FactoryGirl.define do
  factory :subject do |subject|
    name {Faker::Lorem.word}
    instruction {Faker::Lorem.paragraph}
  end
end
