require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'validation' do
    describe 'url' do

      it '空文字はOKであること' do
        event = build(:event)
        event.url = ''
        expect(event).to be_valid
      end

      it 'URLの形であること' do
        event = build(:event)
        event.url = 'http://rubyist-connect.co'
        expect(event).to be_valid
      end

      it 'URLの形出ない場合はエラーになること' do
        event = build(:event)
        event.url = 'some value'
        expect(event).not_to be_valid
      end
    end
  end
end
