require "rails_helper"

describe UserSubjectsController, type: :controller do
  let(:user) {FactoryGirl.create :user}
  let(:course_subject) {FactoryGirl.create :course_subject_active}
  let(:user_subject) {FactoryGirl.create :user_subject, user: user,
    course_subject: course_subject}

  before :each do
    request.env["HTTP_REFERER"] = root_url
  end

  describe "PUT /update" do
    let(:task) {FactoryGirl.create :task, subject: subject}
    let(:course_subject_task) {FactoryGirl.create :course_subject_task,
      course_subject: course_subject, task: task}

    it "check @user_subject" do
      sign_in user

      allow(UserSubject).to receive(:find).and_return user_subject
      allow(user_subject).to receive(:update_attributes).and_return true

      put :update, id: user_subject.id, user_subject: {status: :finished}
      expect(response).to redirect_to(:back)
    end

    it "check content type" do
      sign_in user
      put :update, id: user_subject.id, user_subject: {status: :finished}

      expect(response.status).to eq(302)
      expect(response.content_type).to eq "text/html"
    end

    it "without login" do
      put :update, id: user_subject.id, user_subject: {status: :finished}
      expect(response.status).to eq(302)
      expect(response).to redirect_to(new_user_session_url)
    end
  end
end
