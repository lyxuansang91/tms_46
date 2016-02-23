FactoryGirl.define do
  factory :course_subject do |course_subject|
    course
    subject

    factory :course_subject_active do
      after(:create) {|course_subject| course_subject.active!}
    end

    factory :course_subject_inactive do
      after(:create) {|course_subject| course_subject.inactive!}
    end

    factory :course_subject_finished do
      after(:create) {|course_subject| course_subject.finished!}
    end
  end
end
