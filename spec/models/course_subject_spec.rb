require "rails_helper"

describe CourseSubject, type: :model do
  let(:course_subject) {FactoryGirl.create :course_subject}
  it {is_expected.to respond_to :status}

  subject {course_subject}

  context "attribute" do
    it {expect(subject.course).not_to be_nil}
    it {expect(subject.subject).not_to be_nil}
  end

  context "check enum status" do
    it {should define_enum_for(:status).with([:inactive, :active, :finished])}
  end

  describe "associations" do
    it {should have_many(:course_subject_tasks)}
    it {should have_many(:tasks).through(:course_subject_tasks)}
    it {should have_many(:user_subjects)}
    it {should have_many(:users).through(:user_subjects)}
    it {should belong_to(:course)}
    it {should belong_to(:subject)}
  end
end
