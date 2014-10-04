class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # ログイン／ユーザ登録済みチェック
  def signed_in?
    User.where(id: session[:user_id]).exists?
  end
  helper_method :signed_in?

end
