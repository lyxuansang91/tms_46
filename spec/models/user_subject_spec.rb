require "rails_helper"

describe UserSubject, type: :model do
  let(:user_subject) {FactoryGirl.create :user_subject}
  it {is_expected.to respond_to :status}

  subject {course_subject}

  context "attribute" do
    it {expect(subject.course).not_to be_nil}
    it {expect(subject.subject).not_to be_nil}
  end

   context "check enum status" do
    it {should define_enum_for(:status).with([:open, :finished])}
  end

  describe "associations" do
    it {should belong_to(:user)}
    it {should belong_to(:course_subject)}
  end
end
