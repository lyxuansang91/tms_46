require "rails_helper"
require "cancan/matchers"
require "admin/courses_controller"

describe Admin::CourseSubjectsController, type: :controller do
  let(:user) {FactoryGirl.create :user}
  let(:supervisor) {FactoryGirl.create :supervisor}
  let(:course) {FactoryGirl.create :course}
  let(:subject) {FactoryGirl.create :subject}
  let(:course_subject) {FactoryGirl.create :course_subject, course: course,
    subject: subject}

  before :each do
    request.env["HTTP_REFERER"] = root_url
  end

  describe "GET /courses/:course_id/course_subjects" do
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

    it "renders the admin/course_subjects/index template" do
      sign_in supervisor
      get :index, course_id: course.id
      expect(response).to render_template("admin/course_subjects/index")
      expect(response).to render_template("layouts/application")
    end

    it "check @course" do
      sign_in supervisor
      get :index, course_id: course.id
      allow(Course).to receive(:find) {course}
      expect(Course.find(course.id)).to eq course
      expect(assigns(:course)).to eq course
    end

    it "check @course_subjects" do
      sign_in supervisor
      get :index, course_id: course.id
      expect(assigns(:course_subjects)).to eq [course_subject]
    end
  end

  describe "GET /course_subjects/:id" do

    context "unauthorize access denied" do
      it "unauthorize with trainee" do
        sign_in user
        get :show, id: course_subject.id
        expect(response.status).to eq(302)
        expect(response).to redirect_to root_url
      end

      it "unauthorize anonymous" do
        get :show, id: course_subject.id
        expect(response.status).to eq(302)
        expect(response).to redirect_to new_user_session_url
      end
    end

    it "authorize accessed" do
      sign_in supervisor
      get :show, id: course_subject.id
      expect(response.status).to eq(200)
      expect(response.content_type).to eq "text/html"
    end

    it "renders course subject show template" do
      sign_in supervisor
      get :show, id: course_subject.id
      expect(response).to render_template("admin/course_subjects/show")
      expect(response).to render_template("layouts/application")
    end
  end

  describe "UPDATE /course_subjects/:id" do
    context "unauthorize access denied" do
      it "unauthorize with trainee" do
        sign_in user
        put :update, id: course_subject.id, course_subject: {course_id: course.
          id, subject_id: subject.id, user_subjects_attributes: {}}

        expect(response.status).to eq(302)
        expect(response).to redirect_to root_url
      end

      it "unauthorize anonymous" do
        put :update, id: course_subject.id, course_subject: {course_id: course.
          id, subject_id: subject.id, user_subjects_attributes: {}}

        expect(response.status).to eq(302)
        expect(response).to redirect_to new_user_session_url
      end
    end

    it "authorize accessed" do
      sign_in supervisor
      put :update, id: course_subject.id, course_subject: {course_id: course.
        id, subject_id: subject.id, user_subjects_attributes: {}}
      expect(response.status).to eq(302)
      expect(response.content_type).to eq "text/html"
    end

    it "update course_subject success" do
      sign_in supervisor
      allow(CourseSubject).to receive(:find).and_return course_subject
      allow(course_subject).to receive(:update_attributes).and_return true
      put :update, id: course_subject.id, course_subject: {course_id: course.
          id, subject_id: subject.id, user_subjects_attributes: {}}
      expect(CourseSubject.find(course_subject.id)).to eq(course_subject)
      expect(response).to redirect_to [:admin, course_subject.course]
    end

    it "update course_subject failed" do
      sign_in supervisor
      allow(CourseSubject).to receive(:find).and_return course_subject
      allow(course_subject).to receive(:update_attributes).and_return false
      put :update, id: course_subject.id, course_subject: {course_id: course.
        id, subject_id: subject.id, user_subjects_attributes: {}}
      expect(CourseSubject.find(course_subject.id)).to eq(course_subject)
      expect(response).to redirect_to [:admin, course_subject]
    end
  end
end
