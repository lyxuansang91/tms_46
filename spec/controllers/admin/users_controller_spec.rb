require "rails_helper"
require "cancan/matchers"
require "admin/users_controller"

describe Admin::UsersController, type: :controller do
  let(:user) {FactoryGirl.create :user}
  let(:supervisor) {FactoryGirl.create :supervisor}

  describe "GET /users" do
    context "unauthorize access denied" do
      it "unauthorize with trainee" do
        sign_in user
        get :index
        expect(response.status).to eq(302)
        expect(response).to redirect_to root_url
      end

      it "unauthorize anonymous" do
        get :index
        expect(response.status).to eq(302)
        expect(response).to redirect_to new_user_session_url
      end
    end

    it "authorize accessed" do
      sign_in supervisor
      get :index
      expect(response.status).to eq(200)
      expect(response.content_type).to eq "text/html"
    end

    it "renders the admin/users/index template" do
      sign_in supervisor
      get :index
      expect(response).to render_template("admin/users/index")
      expect(response).to render_template("layouts/application")
    end

    it "check @users" do
      sign_in supervisor
      get :index
      expect(assigns(:users)).to eq [supervisor]
    end
  end

  describe "GET /users/:id" do
    let(:course) {FactoryGirl.create :course}

    context "unauthorize access denied" do
      it "unauthorize with trainee" do
        sign_in user
        get :show, id: user.id
        expect(response.status).to eq(302)
        expect(response).to redirect_to root_url
      end

      it "unauthorize anonymous" do
        get :show, id: user.id
        expect(response.status).to eq(302)
        expect(response).to redirect_to new_user_session_url
      end
    end

    it "authorize accessed" do
      sign_in supervisor
      get :show, id: supervisor.id
      expect(response.status).to eq(200)
      expect(response.content_type).to eq "text/html"
    end

    it "renders the index template" do
      sign_in supervisor
      get :show, id: supervisor.id
      expect(response).to render_template("admin/users/show")
      expect(response).to render_template("layouts/application")
    end

    it "check @user" do
      sign_in supervisor
      get :show, id: supervisor.id
      allow(User).to receive(:find) {supervisor}
      expect(User.find(supervisor.id)).to eq supervisor
    end

    it "check @courses" do
      sign_in supervisor
      get :show, id: supervisor.id
      course.user_courses.create user_id: supervisor.id
      expect(assigns(:courses)).to eq [course]
    end
  end
end
