class ApplicationController < ActionController::Base
  before_action :authenticate_user!, :prepare_search_users, :current_user_profile
  protect_from_forgery with: :exception

  def prepare_search_users
    @q = User.order(:id).reverse_order.without_login_user(current_user).ransack(params[:q])
  end

  def current_user_profile
    @current_user_profile = set_user
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = current_user
  end

end
