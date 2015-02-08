class ApplicationController < ActionController::Base
  before_action :authenticate_user!, :prepare_search_users
  protect_from_forgery with: :exception

  def prepare_search_users
    @q = User.order(:id).reverse_order.without_login_user(current_user).ransack(params[:q])
  end
end
