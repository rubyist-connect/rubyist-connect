require 'rails_helper'

describe 'db/seeds.rb' do
  it 'saves data' do
    load Rails.root + "db/seeds.rb"
    expect(User.count).to eq 10
    expect(Event.count).to eq 5
  end
end