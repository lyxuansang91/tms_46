require "rails_helper"

describe CourseSubjectTask, type: :model do
  let(:course_subject_task){FactoryGirl.create :course_subject_task}
  subject {course_subject_task}

  context "attribute" do
    it {expect(subject.course_subject).not_to be_nil}
    it {expect(subject.task).not_to be_nil}
  end

  describe "associations" do
    it {should have_many(:user_tasks)}
    it {should have_many(:users).through(:user_tasks)}
    it {should belong_to(:task)}
    it {should belong_to(:course_subject)}
  end
end
