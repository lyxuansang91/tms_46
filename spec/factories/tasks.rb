FactoryGirl.define do
  factory :task do
    name {Faker::Lorem.word}
    subject {FactoryGirl.create :subject}
  end
end
