FactoryGirl.define do
  factory :course_subject_task do
    task {FactoryGirl.create :task}
    course_subject do
      subject = task.subject
      course_subject = FactoryGirl.create :course_subject, subject: subject
    end
  end
end
