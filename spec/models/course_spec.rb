require "rails_helper"

describe Course, type: :model do
  let(:course1) {FactoryGirl.create :course}
  let(:course2) {FactoryGirl.build :course}
  it{is_expected.to respond_to :name}
  it{is_expected.to respond_to :instruction}
  it{is_expected.to respond_to :status}
end
