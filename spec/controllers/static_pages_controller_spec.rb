require "rails_helper"
require "cancan/matchers"

describe StaticPagesController, type: :controller do
  let(:user) {FactoryGirl.create :user}

  describe "GET /root" do
    it "renders home template" do
      sign_in user
      get :home
      expect(response.status).to eq(200)
      expect(response.content_type).to eq "text/html"
      expect(response).to render_template("static_pages/home")
      expect(response).to render_template("layouts/application")
    end

    it "check content-type and status" do
      sign_in user
      get :home
      expect(response.status).to eq(200)
      expect(response.content_type).to eq "text/html"
    end

    it "without login" do
      get :home
      expect(response.status).to eq(302)
      expect(response).to redirect_to(new_user_session_url)
    end
  end

  describe "GET /about" do
    it "render about template" do
      sign_in user
      get :about
      expect(response.status).to eq(200)
      expect(response.content_type).to eq "text/html"
      expect(response).to render_template("static_pages/about")
      expect(response).to render_template("layouts/application")
    end

    it "check content type and status" do
      sign_in user
      get :home
      expect(response.status).to eq(200)
      expect(response.content_type).to eq "text/html"
    end

    it "without login" do
      get :home
      expect(response.status).to eq(302)
      expect(response).to redirect_to(new_user_session_url)
    end
  end
end
