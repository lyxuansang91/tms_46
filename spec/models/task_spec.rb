require "rails_helper"

describe Task, type: :model do
  let(:task) {FactoryGirl.create :task}
  it{is_expected.to respond_to :name}
  describe "validates" do
    context "invalid input" do
      it "name is blank" do
        task.name = ""
        expect(task).not_to be_valid
      end
    end
  end

  subject {task}

  context "subject_id attribute" do
    it {expect(task.subject_id).not_to be_nil}
  end

  describe "associations" do
    it {should have_many(:course_subject_tasks)}
    it {should have_many(:course_subjects).through(:course_subject_tasks)}
    it {should belong_to(:subject)}
  end
end
