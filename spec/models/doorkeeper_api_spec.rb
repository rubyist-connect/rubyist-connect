require 'rails_helper'

describe DoorkeeperApi do
  describe '::fetch_attendees' do
    let(:expected) do
      [
          {
              :name => "Yuji Shimoda",
              :facebook => nil,
              :twitter => "yuji_shimoda",
              :github => "yuji-shimoda"
          },
          {
              :name => "Yuya",
              :facebook => "yuyakato1984",
              :twitter => "nayutaya",
              :github => "nayutaya"
          },
          {
              :name => "原孝道",
              :facebook => "takamichi.hara",
              :twitter => nil,
              :github => nil
          },
          {
              :name => "Takahiro YAOTA (YuZakuro)",
              :facebook => "zakuro9715",
              :twitter => "zakuro9715",
              :github => "zakuro9715"
          },
          {
              :name => "たかえす ゆうじ(yusabana)",
              :facebook => "yu.takaesu",
              :twitter => "yusabana",
              :github => "yusabana"
          },
          {
              :name => "村上 健太",
              :facebook => "kntmrkm",
              :twitter => "kntmrkm",
              :github => "kntmrkm"
          },
          {
              :name => "knmsyk (こうの)",
              :facebook => nil,
              :twitter => "knmsyk",
              :github => "knmsyk"
          },
          {
              :name => "寺田 大輔",
              :facebook => "aq2bq",
              :twitter => "aq2bq",
              :github => "aq2bq"
          },
          {
              :name => "荻 竜也",
              :facebook => "tatsuya.ogi",
              :twitter => "t_oginogin",
              :github => "t-oginogin"
          },
          {
              :name => "やましー",
              :facebook => "100008277219454",
              :twitter => nil,
              :github => "yamasy1549"
          },
          {
              :name => "Aki ",
              :facebook => nil,
              :twitter => "spring_aki",
              :github => nil
          },
          {
              :name => "otokunaga",
              :facebook => "profile.php?id=100008140051101",
              :twitter => "otokunaga2",
              :github => nil
          },
          {
              :name => "伊藤淳一",
              :facebook => "junichi.ito.717",
              :twitter => "jnchito",
              :github => nil
          },
          {
              :name => "たいら",
              :facebook => "app_scoped_user_id",
              :twitter => "macha3k",
              :github => "m-taira"
          }
      ]
    end
    example do
      event_id = '24544'
      result = DoorkeeperApi.fetch_attendees(event_id)
      expect(result.size).to eq 14
      expect(result).to eq expected
    end
  end
end