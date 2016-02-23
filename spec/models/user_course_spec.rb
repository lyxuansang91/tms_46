require "rails_helper"

describe UserCourse, type: :model do
  let(:user_course) {FactoryGirl.create :user_course}
  it {is_expected.to respond_to :status}

  subject {user_course}

  context "user_id attribute" do
    it {expect(subject.user_id).not_to be_nil}
  end

  context "course_id attribute" do
    it {expect(subject.course_id).not_to be_nil}
  end

  context "check enum status" do
    it {should define_enum_for(:status).with([:active, :finished])}
  end

  describe "associations" do
    it {should belong_to(:user)}
    it {should belong_to(:course)}
  end
end
