class UsersController < ApplicationController
  before_action :authorize_access

  def index
    @users = User.all
  end

  private

  def authorize_access
    redirect_to root_path unless signed_in?
  end
end
