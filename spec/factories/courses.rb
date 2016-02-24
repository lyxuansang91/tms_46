FactoryGirl.define do
  factory :course do
    name {Faker::Lorem.word}
    instruction {Faker::Lorem.paragraph}

    factory :course_active do
      after(:create) {|course| course.active! }
    end
  end
end
