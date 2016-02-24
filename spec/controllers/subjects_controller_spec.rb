require "rails_helper"

describe SubjectsController, type: :controller do
  let(:user) {FactoryGirl.create :user}
  let(:subject) {FactoryGirl.create :subject}

  describe "GET /index" do
    it "renders course index template" do
      sign_in :user, user
      allow(request.env["warden"]).to receive(:authenticate!).and_return(user)
      allow(controller).to receive(:current_user).and_return user
      get :index
      expect(response).to render_template("subjects/index")
      expect(response).to render_template("layouts/application")
    end

    it "check @subjects" do
      sign_in :user, user
      allow(request.env["warden"]).to receive(:authenticate!).and_return(user)
      allow(controller).to receive(:current_user).and_return user
      get :index
      expect(assigns(:subjects)).to eq([subject])
    end

    it "check content type" do
      sign_in :user, user
      allow(request.env["warden"]).to receive(:authenticate!).and_return(user)
      allow(controller).to receive(:current_user).and_return user
      get :index
      expect(response.status).to eq(200)
      expect(response.content_type).to eq "text/html"
    end

    it "without login" do
      get :index
      expect(response.status).to eq(302)
      expect(response).to redirect_to(new_user_session_url)
    end
  end

  describe "GET /show" do
    let(:task) {FactoryGirl.create :task, subject: subject}
    it "renders course show template" do
      sign_in :user, user
      allow(request.env["warden"]).to receive(:authenticate!).and_return(user)
      allow(controller).to receive(:current_user).and_return user
      get :show, {id: subject.id}
      expect(response).to render_template("subjects/show")
      expect(response).to render_template("layouts/application")
    end

    it "check @course_subjects" do
      sign_in :user, user
      allow(request.env["warden"]).to receive(:authenticate!).and_return(user)
      allow(controller).to receive(:current_user).and_return user
      get :show, {id: subject.id}
      expect(assigns(:tasks)).to eq([task])
    end

    it "check content type" do
      sign_in :user, user
      allow(request.env["warden"]).to receive(:authenticate!).and_return(user)
      allow(controller).to receive(:current_user).and_return user
      get :show, {id: subject.id}
      expect(response.status).to eq(200)
      expect(response.content_type).to eq "text/html"
    end

    it "without login" do
      get :show, {id: subject.id}
      expect(response.status).to eq(302)
      expect(response).to redirect_to(new_user_session_url)
    end
  end
end
