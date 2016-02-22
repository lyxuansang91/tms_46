require "rails_helper"

describe User, type: :model do
  let(:user1) {FactoryGirl.create :user}
  let(:user2) {FactoryGirl.build :user}
  it{is_expected.to respond_to :name}
  it{is_expected.to respond_to :email}
  it{is_expected.to respond_to :password}
  it{is_expected.to respond_to :password_confirmation}
  it{is_expected.to respond_to :role}
end
