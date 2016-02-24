require "rails_helper"

describe CourseSubjectsController, type: :controller do
  let(:user) {FactoryGirl.create :user}
  let(:course) {FactoryGirl.create :course_active}
  let(:subject) {FactoryGirl.create :subject}
  let(:course_subject) {FactoryGirl.create :course_subject_active, course:
    course, subject: subject}
  let(:user_course) {FactoryGirl.create :user_course, user: user, course:
    course}
  let(:user_subject) {FactoryGirl.create :user_subject, user: user,
    course_subject: course_subject}

  describe "GET /show" do
    let(:task) {FactoryGirl.create :task, subject: subject}
    let(:course_subject_task) {FactoryGirl.create :course_subject_task,
      course_subject: course_subject, task: task}

    it "renders course_subject show template" do
      sign_in :user, user
      allow(request.env["warden"]).to receive(:authenticate!).and_return(user)
      allow(controller).to receive(:current_user).and_return user

      get :show, {course_id: course.id, id: course_subject.id}

      expect(response).to render_template("course_subjects/show")
      expect(response).to render_template("layouts/application")
    end

    it "check @course_subject_tasks" do
      sign_in :user, user
      allow(request.env["warden"]).to receive(:authenticate!).and_return(user)
      allow(controller).to receive(:current_user).and_return user

      get :show, {course_id: course.id, id: course_subject.id}

      CourseSubject.stub(:find).and_return course_subject

      expect(CourseSubject.find(course_subject.id)).to eq course_subject

      expect(assigns(:course_subject_tasks)).to eq([course_subject_task])
    end

    it "check content type" do
      sign_in :user, user
      allow(request.env["warden"]).to receive(:authenticate!).and_return(user)
      allow(controller).to receive(:current_user).and_return user

      get :show, {course_id: course.id, id: course_subject.id}

      expect(response.status).to eq(200)
      expect(response.content_type).to eq "text/html"
    end

    it "without login" do
      get :show, {course_id: course.id, id: course_subject.id}

      expect(response.status).to eq(302)
      expect(response).to redirect_to(new_user_session_url)
    end
  end
end
