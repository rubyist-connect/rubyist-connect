class DoorkeepersController < ApplicationController
  def fetch
    render json: { name: 'Rubyistのためのテストコード相談会 ～テストの書き方に悩んでいませんか？～' }
  end
end