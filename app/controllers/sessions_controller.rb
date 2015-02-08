class SessionsController < Devise::SessionsController
  def destroy
    super
    flash.delete(:notice)
  end
end
