require "rails_helper"
require "cancan/matchers"
require "admin/subjects_controller"

describe Admin::SubjectsController, type: :controller do
  let(:user) {FactoryGirl.create :user}
  let(:supervisor) {FactoryGirl.create :supervisor}
  let(:subject) {FactoryGirl.create :subject}

  before :each do
    request.env["HTTP_REFERER"] = root_url
  end

  describe "GET /subjects" do
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

    it "renders the admin/subjects/index template" do
      sign_in supervisor
      get :index
      expect(response).to render_template("admin/subjects/index")
      expect(response).to render_template("layouts/application")
    end

    it "check @courses" do
      sign_in supervisor
      get :index
      expect(assigns(:subjects)).to eq [subject]
    end
  end

  describe "GET /subjects/:id" do
    let(:task) {FactoryGirl.create :task, subject: subject}
    context "unauthorize access denied" do
      it "unauthorize with trainee" do
        sign_in user
        get :show, id: subject.id
        expect(response.status).to eq(302)
        expect(response).to redirect_to root_url
      end

      it "unauthorize anonymous" do
        get :show, id: subject.id
        expect(response.status).to eq(302)
        expect(response).to redirect_to new_user_session_url
      end
    end

    it "authorize accessed" do
      sign_in supervisor
      get :show, id: subject.id
      expect(response.status).to eq(200)
      expect(response.content_type).to eq "text/html"
    end

    it "renders the show template" do
      sign_in supervisor
      get :show, id: subject.id
      expect(response).to render_template("admin/subjects/show")
      expect(response).to render_template("layouts/application")
    end

    it "check @subject" do
      sign_in supervisor
      get :show, id: subject.id
      allow(Subject).to receive(:find) {subject}
      expect(Subject.find(subject.id)).to eq subject
      expect(assigns(:subject)).to eq(subject)
    end

    it "check @tasks" do
      sign_in supervisor
      get :show, id: subject.id
      expect(assigns(:tasks)).to eq [task]
    end
  end

  describe "UPDATE /subjects/:id" do
    context "unauthorize access denied" do
      it "unauthorize with trainee" do
        sign_in user
        put :update, id: subject.id, subject: {name: subject.name, instruction:
          subject.instruction, tasks_attributes: {}}
        expect(response.status).to eq(302)
        expect(response).to redirect_to root_url
      end

      it "unauthorize anonymous" do
        put :update, id: subject.id, subject: {name: subject.name, instruction:
          subject.instruction, tasks_attributes: {}}
        expect(response.status).to eq(302)
        expect(response).to redirect_to new_user_session_url
      end
    end

    it "authorize accessed" do
      sign_in supervisor
      put :update, id: subject.id, subject: {name: subject.name, instruction:
        subject.instruction, tasks_attributes: {}}
      expect(response.status).to eq(302)
      expect(response.content_type).to eq "text/html"
    end

    it "update success" do
      sign_in supervisor
      allow(Subject).to receive(:find).and_return subject
      allow(subject).to receive(:update_attributes).and_return true
      put :update, id: subject.id, subject: {name: subject.name, instruction:
        subject.instruction, tasks_attributes: {}}
      expect(Subject.find(subject.id)).to eq(subject)
      expect(response).to redirect_to [:admin, subject]
    end
  end

  describe "DELETE /subjects/:id" do
    context "unauthorize access denied" do
      it "unauthorize with trainee" do
        sign_in user
        delete :destroy, id: subject.id
        expect(response.status).to eq(302)
        expect(response).to redirect_to root_url
      end

      it "unauthorize anonymous" do
        delete :destroy, id: subject.id
        expect(response.status).to eq(302)
        expect(response).to redirect_to new_user_session_url
      end
    end

    it "authorize accessed" do
      sign_in supervisor
      delete :destroy, id: subject.id
      expect(response.status).to eq(302)
      expect(response.content_type).to eq "text/html"
    end

    it "delete subject success" do
      sign_in supervisor
      delete :destroy, id: subject.id
      expect(response).to redirect_to [:admin, :subjects]
    end
  end

  describe "POST /subjects" do
    context "unauthorize access denied" do
      it "unauthorize with trainee" do
        sign_in user
        post :create, subject: {name: subject.name, instruction: subject.instruction, tasks_attributes: {}}
        expect(response.status).to eq(302)
        expect(response).to redirect_to root_url
      end

      it "unauthorize anonymous" do
        post :create, subject: {name: subject.name, instruction: subject.instruction, tasks_attributes: {}}
        expect(response.status).to eq(302)
        expect(response).to redirect_to new_user_session_url
      end
    end

    it "authorize accessed" do
      sign_in supervisor
      post :create, subject: {name: subject.name, instruction: subject.instruction, tasks_attributes: {}}
      expect(response.status).to eq(302)
      expect(response.content_type).to eq "text/html"
    end

    it "create subject success" do
      sign_in supervisor
      allow(Subject).to receive(:new).and_return subject
      allow(subject).to receive(:save).and_return true
      post :create, subject: {name: subject.name, instruction: subject.instruction, tasks_attributes: {}}
      expect(response).to redirect_to [:admin, subject]
    end
  end
end
