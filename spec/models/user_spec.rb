require "rails_helper"
require "cancan/matchers"

describe User, type: :model do
  let(:user1) {FactoryGirl.create :user}
  let(:user2) {FactoryGirl.build :user}
  it{is_expected.to respond_to :name}
  it{is_expected.to respond_to :email}
  it{is_expected.to respond_to :password}
  it{is_expected.to respond_to :password_confirmation}
  it{is_expected.to respond_to :role}

  context "invalid input" do
    it "name is blank" do
      user1.name = ""
      expect(user1).not_to be_valid
    end

    it "name has length > 100" do
      user1.name = "1"*101
      expect(user1).not_to be_valid
    end

    it "email is blank" do
      user1.email = ""
      expect(user1).not_to be_valid
    end

    it "password has length < 8" do
      user1.password = "1234567"
      expect(user1).not_to be_valid
    end

    it "password is blank" do
      user1.password = ""
      expect(user1).not_to be_valid
    end

    it "password confirmation is blank" do
      user1.password_confirmation = ""
      expect(user1).not_to be_valid
    end

    it "password does not match" do
      user1.password_confirmation = "12345679"
      expect(user1).not_to be_valid
    end

    it "email is duplicate" do
      user2.email = user1.email
      expect(user2).not_to be_valid
    end
  end

  describe "supervisor ability" do
    subject(:ability_default) {Ability.new supervisor, ""}
    subject(:ability_devise) {Ability.new supervisor, "Devise"}
    subject(:ability_admin) {Ability.new supervisor, "Admin"}
    context "when user is supervisor" do
      let(:supervisor) {FactoryGirl.create :supervisor}
      it {should be_able_to(:manage, :all)}
    end
  end

  describe "trainee ability normal" do
    subject(:ability) {Ability.new trainee, ""}
    context "when user is trainee" do
      let(:trainee) {FactoryGirl.create :user}
      let(:other_trainee) {FactoryGirl.create :user}
      let(:course_active) {FactoryGirl.create :course_active}
      it {should be_able_to(:show, other_trainee)}
      it {should be_able_to(:show, course_active)}
      it {should be_able_to(:update, trainee)}
      it {should_not be_able_to(:update, other_trainee)}
    end
  end

   describe "trainee ability in admin" do
    subject(:ability) {Ability.new trainee, "Admin"}
    context "when user is trainee" do
      let(:trainee) {FactoryGirl.create :user}
      it {should_not be_able_to(:read, :all)}
    end
  end
end
