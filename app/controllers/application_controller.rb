class ApplicationController < ActionController::Base
  before_action :authenticate_user!, :prepare_search_users
  protect_from_forgery with: :exception

  def prepare_search_users
    @q = User.order(:id).reverse_order.without_login_user(current_user).ransack(params[:q])
  end

  # https://github.com/plataformatec/devise/wiki/OmniAuth%3A-Overview#using-omniauth-without-other-authentications
  def new_session_path(scope)
    root_path
  end
end
