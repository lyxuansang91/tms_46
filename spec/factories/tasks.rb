FactoryGirl.define do
  factory :task do |task|
    name {Faker::Lorem.word}
    subject {FactoryGirl.create :subject}
  end
end
