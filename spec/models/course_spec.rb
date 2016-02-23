require "rails_helper"

describe Course, type: :model do
  let(:course1) {FactoryGirl.create :course}
  let(:course2) {FactoryGirl.build :course}
  it{is_expected.to respond_to :name}
  it{is_expected.to respond_to :instruction}
  it{is_expected.to respond_to :status}
  describe "validates" do
    context "invalid input" do
      it "name is blank" do
        course1.name = ""
        expect(course1).not_to be_valid
      end

      it "instruction is blank" do
        course1.instruction = ""
        expect(course1).not_to be_valid
      end
    end
  end

  context "check enum status" do
    it {should define_enum_for(:status).with([:inactive, :active, :finished])}
  end

  subject {course1}

  describe "associations" do
    it {should have_many(:user_courses)}
    it {should have_many(:users).through(:user_courses)}
    it {should have_many(:course_subjects)}
    it {should have_many(:subjects).through(:course_subjects)}
  end

  describe "accept nested attributes for" do
    it {should accept_nested_attributes_for(:user_courses)}
    it {should accept_nested_attributes_for(:course_subjects)}
  end
end
