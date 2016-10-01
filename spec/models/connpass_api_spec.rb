require 'rails_helper'

describe ConnpassApi do
  describe '::fetch_event_details' do
    let(:expected) do
      {
          "status" => "success",
          "event" => {
              "title" => "もくもく会＃８",
              "participant_profiles" => expected_profiles
          },
      }
    end

    let(:expected_profiles) do
      [
          {
              "name" => "akira-noguchi",
              "facebook" => nil,
              "twitter" => "nodic",
              "github" => nil
          },
          {
              "name" => "Djokov07",
              "facebook" => nil,
              "twitter" => "Djokov07",
              "github" => nil
          },
          {
              "name" => "shojik",
              "facebook" => "883815278321042",
              "twitter" => "kobayashi_shoji",
              "github" => nil
          },
          {
              "name" => "TakehiroIkeda",
              "facebook" => "653974814669478",
              "twitter" => nil,
              "github" => nil
          },
          {
              "name" => "masanari_takegawa",
              "facebook" => nil,
              "twitter" => nil,
              "github" => nil
          },
          {
              "name" => "sakaguchi_yusuke",
              "facebook" => nil,
              "twitter" => nil,
              "github" => "GuCode"
          },
      ]
    end

    example 'as hash' do
      event_url = 'http://connpass.com/event/39406/'
      VCR.use_cassette 'connpass_events/39406', match_requests_on: [:uri] do
        result = ConnpassApi.fetch_event_details(event_url)
        expect(result).to match expected
      end
    end
  end
end