require "rails_helper"
require "cancan/matchers"
require "admin/courses_controller"

describe Admin::CoursesController, type: :controller do
  let(:user) {FactoryGirl.create :user}
  let(:supervisor) {FactoryGirl.create :supervisor}
  let(:course) {FactoryGirl.create :course}

  before :each do
    request.env["HTTP_REFERER"] = root_url
  end

  describe "GET /courses" do
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

    it "renders the admin/courses/index template" do
      sign_in supervisor
      get :index
      expect(response).to render_template("admin/courses/index")
      expect(response).to render_template("layouts/application")
    end

    it "check @courses" do
      sign_in supervisor
      get :index
      expect(assigns(:courses)).to eq [course]
    end
  end

  describe "GET /courses/:id" do

    context "unauthorize access denied" do
      it "unauthorize with trainee" do
        sign_in user
        get :show, id: course.id
        expect(response.status).to eq(302)
        expect(response).to redirect_to root_url
      end

      it "unauthorize anonymous" do
        get :show, id: course.id
        expect(response.status).to eq(302)
        expect(response).to redirect_to new_user_session_url
      end
    end

    it "authorize accessed" do
      sign_in supervisor
      get :show, id: course.id
      expect(response.status).to eq(200)
      expect(response.content_type).to eq "text/html"
    end

    it "renders the show template" do
      sign_in supervisor
      get :show, id: course.id
      expect(response).to render_template("admin/courses/show")
      expect(response).to render_template("layouts/application")
    end

    it "check @course" do
      sign_in supervisor
      get :show, id: course.id
      allow(Course).to receive(:find) {course}
      expect(Course.find(course.id)).to eq course
      expect(assigns(:course)).to eq(course)
    end
  end

  describe "UPDATE /courses/:id" do
    context "unauthorize access denied" do
      it "unauthorize with trainee" do
        sign_in user
        put :update, id: course.id, course: {user_courses_attributes: {},
          course_subjects_attributes: {}}
        expect(response.status).to eq(302)
        expect(response).to redirect_to root_url
      end

      it "unauthorize anonymous" do
        put :update, id: course.id, course: {user_courses_attributes: {},
          course_subjects_attributes: {}}
        expect(response.status).to eq(302)
        expect(response).to redirect_to new_user_session_url
      end
    end

    it "authorize accessed" do
      sign_in supervisor
      put :update, id: course.id, course: {user_courses_attributes: {},
        course_subjects_attributes: {}}
      expect(response.status).to eq(302)
      expect(response.content_type).to eq "text/html"
    end

    it "update course success" do
      sign_in supervisor
      allow(Course).to receive(:find).and_return course
      allow(course).to receive(:update_attributes).and_return true
      put :update, id: course.id, course: {user_courses_attributes: {},
        course_subjects_attributes: {}}
      expect(Course.find(course.id)).to eq(course)
      expect(response).to redirect_to [:admin, course]
    end
  end

  describe "POST /courses" do
    context "unauthorize access denied" do
      it "unauthorize with trainee" do
        sign_in user
        post :create, course: {name: course.name, instruction: course.instruction}
        expect(response.status).to eq(302)
        expect(response).to redirect_to root_url
      end

      it "unauthorize anonymous" do
        post :create, course: {name: course.name, instruction: course.instruction}
        expect(response.status).to eq(302)
        expect(response).to redirect_to new_user_session_url
      end
    end

    it "authorize accessed" do
      sign_in supervisor
      post :create, course: {name: course.name, instruction: course.instruction}
      expect(response.status).to eq(302)
      expect(response.content_type).to eq "text/html"
    end

    it "create success" do
      sign_in supervisor
      user_course = course.user_courses.create user_id: supervisor.id
      allow(Course).to receive(:new).and_return course
      allow(course).to receive(:save!).and_return true
      allow(UserCourse).to receive(:create!).and_return true
      post :create, course: {name: course.name, instruction: course.instruction}
      expect(response).to redirect_to [:admin, course]
    end
  end

   describe "DELETE /courses/:id" do
    context "unauthorize access denied" do
      it "unauthorize with trainee" do
        sign_in user
        delete :destroy, id: course.id
        expect(response.status).to eq(302)
        expect(response).to redirect_to root_url
      end

      it "unauthorize anonymous" do
        delete :destroy, id: course.id
        expect(response.status).to eq(302)
        expect(response).to redirect_to new_user_session_url
      end
    end

    it "authorize accessed" do
      sign_in supervisor
      delete :destroy, id: course.id
      expect(response.status).to eq(302)
      expect(response.content_type).to eq "text/html"
    end

    it "delete success" do
      sign_in supervisor
      allow(course).to receive(:destroy).and_return true
      delete :destroy, id: course.id
      expect(response).to redirect_to :back
    end
  end
end
