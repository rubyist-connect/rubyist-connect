class ApplicationController < ActionController::Base
  before_action :authenticate_user!, :prepare_search_users
  protect_from_forgery with: :exception

  def prepare_search_users
    @q = User.order(:id).reverse_order.ransack(params[:q])
  end
end
