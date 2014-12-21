class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    @user = User.find_or_create_from_auth_hash(auth_hash)
    sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated

    # TODO 認証に失敗したときの処理も必要。以下は公式ページのサンプルコード。
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