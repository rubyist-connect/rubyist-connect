class UsersController < ApplicationController
  before_action :set_user, only: [:update]
  before_action :authorize_access

  def index
    @users = User.search(params[:search])
  end

  def show
    @user = User.find_by_nickname(params[:nickname])
  end

  def edit
    @user = User.find(session[:user_id])
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: '更新しました。' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @user = User.find(session[:user_id])
    @user.destroy
    respond_to do |format|
      format.html { redirect_to :root, notice: '退会しました。' }
    end
  end


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    #params[:user]
    params.require(:user).permit(:introduction, :twitter_name, :facebook_name, :location, :name, :blog)
  end

  def authorize_access
    redirect_to root_path unless signed_in?
  end
end
