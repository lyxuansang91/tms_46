FactoryGirl.define do
  factory :subject do |subject|
    name {Faker::Lorem.word}
    instruction {Faker::Lorem.paragraph}
    subject.after(:create) do |subject|
      3.times {subject.tasks << FactoryGirl.build(:task)}
    end
  end
end
