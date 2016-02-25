require "rails_helper"
require "cancan/matchers"
require "courses_controller"

describe CoursesController, type: :controller do
  let(:user) {FactoryGirl.create :user}
  let(:course) {FactoryGirl.create :course_active}
  let(:user_course) {FactoryGirl.create :user_course, user: user, course: course}

  describe "GET /index" do
    let(:user_course) {FactoryGirl.create :user_course, user: user, course: course}
    it "renders course index template" do
      sign_in user
      get :index
      expect(response).to render_template("courses/index")
      expect(response).to render_template("layouts/application")
    end

    it "check @courses" do
      sign_in user
      get :index
      expect(assigns(:courses)).to eq([course])
    end

    it "check content type" do
      sign_in user
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

    let(:subject) {FactoryGirl.create :subject}
    let(:course_subject) {FactoryGirl.create :course_subject_active, course: course, subject: subject}
    let(:user_subject) {FactoryGirl.create :user_subject, course_subject: course_subject}

    it "renders course show template" do
      sign_in user
      get :show, {id: course.id}
      expect(response).to render_template("courses/show")
      expect(response).to render_template("layouts/application")
    end

    it "check @course_subjects" do
      sign_in user
      get :show, {id: course.id}
      expect(assigns(:course_subjects)).to eq([course_subject])
    end

    it "check content type" do
      sign_in user
      get :show, {id: course.id}
      expect(response.status).to eq(200)
      expect(response.content_type).to eq "text/html"
    end

    it "without login" do
      get :show, {id: course.id}
      expect(response.status).to eq(302)
      expect(response).to redirect_to(new_user_session_url)
    end
  end
end
