require "rails_helper"
require "cancan/matchers"
require "users_controller"

describe UsersController, type: :controller do
  let(:user) {FactoryGirl.create :user}

  before do
    sign_in :user, user
    allow(request.env["warden"]).to receive(:authenticate!).and_return(user)
    allow(controller).to receive(:current_user).and_return user
  end

  describe "GET /users" do
    it "renders the index template" do
      get :index
      user = double("user")
      expect(response).to render_template("users/index")
      expect(response).to render_template("layouts/application")
    end
  end

  describe "GET show" do
    it "check show" do
      get :show, id: user.id
      other_user = double("user")
      allow(User).to receive(:find).and_return(other_user)
      expect(User.find(user.id)).to eq(other_user)
      expect(response).to render_template :show
    end
  end
end
