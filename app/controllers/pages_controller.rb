class PagesController < ApplicationController
  def letsencrypt
    if params[:id] == ENV["LETSENCRYPT_REQUEST"]
      render text: ENV["LETSENCRYPT_RESPONSE"]
    end
  end
end
