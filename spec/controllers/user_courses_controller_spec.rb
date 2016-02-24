require "rails_helper"

describe UserCoursesController, type: :controller do

  let(:course) {FactoryGirl.create :course_active}
  let(:user) {FactoryGirl.create :user}

  describe "GET /index" do
    it "renders user_course index template" do
      sign_in :user, user
      allow(request.env["warden"]).to receive(:authenticate!).and_return(user)
      allow(controller).to receive(:current_user).and_return user

      get :index, {course_id: course.id}

      expect(response).to render_template("user_courses/index")
      expect(response).to render_template("layouts/application")
    end

    it "check @users" do
      sign_in :user, user
      allow(request.env["warden"]).to receive(:authenticate!).and_return(user)
      allow(controller).to receive(:current_user).and_return user

      get :index, {course_id: course.id}
      user_course = course.user_courses.create user_id: user.id

      expect(assigns(:users)).to eq([user])
    end

    it "check content type" do
      sign_in :user, user
      allow(request.env["warden"]).to receive(:authenticate!).and_return(user)
      allow(controller).to receive(:current_user).and_return user
      get :index, {course_id: course.id}

      expect(response.status).to eq(200)
      expect(response.content_type).to eq "text/html"
    end

    it "without login" do
      get :index, {course_id: course.id}

      expect(response.status).to eq(302)
      expect(response).to redirect_to(new_user_session_url)
    end
  end
end
