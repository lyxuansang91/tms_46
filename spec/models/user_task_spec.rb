require "rails_helper"

describe UserTask, type: :model do
  let(:user_task) {FactoryGirl.create :user_task}
  it{is_expected.to respond_to :status}

  subject {user_task}

  context "attributes" do
    it {expect(subject.user).not_to be_nil}
    it {expect(subject.course_subject_task).not_to be_nil}
  end

  describe "associations" do
    it {should belong_to(:user)}
    it {should belong_to(:course_subject_task)}
  end
end
