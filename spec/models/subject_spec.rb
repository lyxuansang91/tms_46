require "rails_helper"

describe Subject, type: :model do
  let(:subject1) {FactoryGirl.create :subject}
  let(:subject2) {FactoryGirl.build :subject}
  it{is_expected.to respond_to :name}
  it{is_expected.to respond_to :instruction}
  describe "validates" do
    context "invalid input" do
      it "name is blank" do
        subject1.name = ""
        expect(subject1).not_to be_valid
      end

      it "instruction is blank" do
        subject1.instruction = ""
        expect(subject1).not_to be_valid
      end
    end
  end

  subject {subject1}

  describe "associations" do
    it {should have_many(:course_subjects)}
    it {should have_many(:courses).through(:course_subjects)}
    it {should have_many(:tasks)}
  end

  describe "accept nested attributes for" do
    it {should accept_nested_attributes_for(:tasks)}
  end
end
