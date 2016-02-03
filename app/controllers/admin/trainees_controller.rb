class Admin::TraineesController < ApplicationController
  load_and_authorize_resource :course

  def index
    @users = User.trainee_users.page(params[:page]).per Settings.per_page
  end
end
