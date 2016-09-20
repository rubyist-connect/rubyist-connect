class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    user = User.find_or_create_from_auth_hash(auth_hash)

    unless user.active?
      session[:user_return_to] = edit_user_path
      flash[:alert] = t('flash_messages.warning_for_nonactive_users')
    end

    nickname = request.env['omniauth.params']['nickname']
    if nickname == nil
      sign_in_and_redirect user, event: :authentication #this will throw if @user is not activated
    else
      sign_in user
      redirect_to user_path(nickname), event: :authentication
    end

    # TODO 認証を拒否した場合のフローも必要な気がするが、GitHubは拒否するボタンがないのでテストできない？
    # 以下は公式ページのサンプルコード
    # # You need to implement the method below in your model (e.g. app/models/user.rb)
    # @user = User.from_omniauth(request.env["omniauth.auth"])
    #
    # if @user.persisted?
    #   sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
    #   set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    # else
    #   session["devise.facebook_data"] = request.env["omniauth.auth"]
    #   redirect_to new_user_registration_url
    # end
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end
end
