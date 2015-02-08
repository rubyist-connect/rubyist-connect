class UsersController < ApplicationController
  before_action :set_user, only: %i(edit update destroy)
  before_action :current_user_profile

  def index
    @users = @q.result.active.page params[:page]
    flash.now[:alert] = "該当するユーザーが見つかりません" if @users.empty?
  end

  def show
    @user = User.find_by_nickname!(params[:nickname])
  end

  def edit
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(nickname: @user.nickname), notice: '更新しました。' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to :root, notice: '退会しました。' }
    end
  end

  def current_user_profile
    @current_user_profile = set_user
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = current_user
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:introduction, :twitter_name, :facebook_name, :qiita_name, :location, :name, :blog, :birthday)
  end
end
