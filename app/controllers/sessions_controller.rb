class SessionsController < ApplicationController

  def create
    user = User.find_or_create_from_auth_hash(auth_hash)
    session[:user_id] = user.id
    flash[:notice]    = "ログインしました。"

    # 保管URLへリダイレクト
    unless session[:request_url].blank?
      redirect_to session[:request_url]
      session[:request_url] = nil
      return
    end

    redirect_to "/nnect"
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end

end
