require "rails_helper"
require "cancan/matchers"
require "admin/supervisors_controller"

describe Admin::SupervisorsController, type: :controller do
  let(:user) {FactoryGirl.create :user}
  let(:supervisor) {FactoryGirl.create :supervisor}
  let(:course) {FactoryGirl.create :course}

  before :each do
    request.env["HTTP_REFERER"] = root_url
  end

  describe "GET /courses/:course_id/supervisors" do
    context "unauthorize access denied" do
      it "unauthorize with trainee" do
        sign_in user
        get :index, course_id: course.id
        expect(response.status).to eq(302)
        expect(response).to redirect_to root_url
      end

      it "unauthorize anonymous" do
        get :index, course_id: course.id
        expect(response.status).to eq(302)
        expect(response).to redirect_to new_user_session_url
      end
    end

    it "authorize accessed" do
      sign_in supervisor
      get :index, course_id: course.id
      expect(response.status).to eq(200)
      expect(response.content_type).to eq "text/html"
    end

    it "renders the admin/trainees/index template" do
      sign_in supervisor
      get :index, course_id: course.id
      expect(response).to render_template("admin/supervisors/index")
      expect(response).to render_template("layouts/application")
    end

    it "check @course" do
      sign_in supervisor
      get :index, course_id: course.id
      allow(Course).to receive(:find) {course}
      expect(Course.find(course.id)).to eq course
      expect(assigns(:course)).to eq course
    end

    it "check @users" do
      sign_in supervisor
      get :index, course_id: course.id
      expect(assigns(:users)).to eq [supervisor]
    end
  end
end
