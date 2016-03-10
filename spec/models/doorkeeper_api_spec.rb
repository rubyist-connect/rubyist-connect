require 'rails_helper'

describe DoorkeeperApi do
  describe '::fetch_event_details' do
    let(:expected) do
      {
          "status" => "success",
          "event" => {
              "title" => "Rubyistのためのテストコード相談会 ～テストの書き方に悩んでいませんか？～",
              "id" => 24544,
              "starts_at" => "2015-05-16T04:00:00.000Z",
              "ends_at" => "2015-05-16T09:00:00.000Z",
              "venue_name" => "阪神深江 Nilquebe（ニルキューブ）",
              "address" => "神戸市東灘区深江本町3-9-1 深江駅前ビル201",
              "lat" => "34.7224488",
              "long" => "135.29165060000003",
              "ticket_limit" => 15,
              "published_at" => "2015-05-01T03:23:25.541Z",
              "updated_at" => "2015-05-16T05:54:28.463Z",
              "group" => 1145,
              "banner" => "https://dzpp79ucibp5a.cloudfront.net/events_banners/24544_normal_1430425474_5227436224_aa52b49262_b.jpg",
              "description" => "<h2>普段抱えているテストコードのモヤモヤをスッキリさせましょう！</h2>\n\n<p>今回の勉強会のテーマは「テストコード」です。<br>\nテストコードに関する疑問や悩みをみんなで持ち寄り、みんなで解決します。</p>\n\n<p>たとえば、こんなことで悩んでいたりしませんか？</p>\n\n<ul>\n<li>テストコードは書いてるけど、独学なので自信がない</li>\n<li>外部サービスと連携する処理のテストコードの書き方が分からない</li>\n<li>みんなどこまで細かくテストケースを作ってるの？</li>\n<li>未経験者なのでテストを書くと言っても、そもそも何から始めたら良いのかわからない</li>\n<li>etc...</li>\n</ul>\n\n<p>こうした参加者のみなさんのお悩みをみんなで議論したり、経験者の知見を参考にしたりながら現実解を探していく勉強会です。</p>\n\n<p>Rubyのテストコードに関する疑問や相談であれば何でもOKですので、みなさんお気軽にご参加ください！</p>\n\n<p><small>Banner image: <a href=\"https://flic.kr/p/8XVYEL\" rel=\"nofollow\">https://flic.kr/p/8XVYEL</a></small></p>\n\n<h2>懇親会もあります！</h2>\n\n<p>本編が終わったあとはビアバッシュ形式の懇親会（参加自由）もあります。<br>\nみんなで楽しくRubyに関する話題で盛り上がりましょう！</p>\n\n<p><img src=\"https://qiita-image-store.s3.amazonaws.com/0/7465/25a4a7ac-1155-e223-0ed6-a0f3b53bfefe.jpeg\" alt=\"16069215349_e0916216c8_c.jpg\" title=\"16069215349_e0916216c8_c.jpg\"></p>",
              "public_url" => "https://nishiwaki-koberb.doorkeeper.jp/events/24544",
              "participants" => 15,
              "waitlisted" => 0,
              "participant_profiles" => expected_profiles
            },
      }
    end

    let(:expected_profiles) do
      [
          {
              "name" => "Yuji Shimoda",
              "facebook" => nil,
              "twitter" => "yuji_shimoda",
              "github" => "yuji-shimoda"
          },
          {
              "name" => "Yuya",
              "facebook" => "app_scoped_user_id",
              "twitter" => "nayutaya",
              "github" => "nayutaya"
          },
          {
              "name" => "原孝道",
              "facebook" => "app_scoped_user_id",
              "twitter" => nil,
              "github" => nil
          },
          {
              "name" => "zakuro",
              "facebook" => "zakuro9715",
              "twitter" => "zakuro9715",
              "github" => "zakuro9715"
          },
          {
              "name" => "たかえす ゆうじ(yusabana)",
              "facebook" => "yu.takaesu",
              "twitter" => "yusabana",
              "github" => "yusabana"
          },
          {
              "name" => "村上 健太",
              "facebook" => "100000233742860",
              "twitter" => "kntmrkm",
              "github" => "kntmrkm"
          },
          {
              "name" => "knmsyk",
              "facebook" => nil,
              "twitter" => "knmsyk",
              "github" => "knmsyk"
          },
          {
              "name" => "寺田 大輔",
              "facebook" => "100002385268769",
              "twitter" => "aq2bq",
              "github" => "aq2bq"
          },
          {
              "name" => "荻 竜也",
              "facebook" => "app_scoped_user_id",
              "twitter" => "t_oginogin",
              "github" => "t-oginogin"
          },
          {
              "name" => "やましー",
              "facebook" => "100008277219454",
              "twitter" => "yamasy1549",
              "github" => "yamasy1549"
          },
          {
              "name" => "Aki ",
              "facebook" => nil,
              "twitter" => "spring_aki",
              "github" => nil
          },
          {
              "name" => "otokunaga",
              "facebook" => "profile.php?id=100008140051101",
              "twitter" => "otokunaga2",
              "github" => nil
          },
          {
              "name" => "伊藤淳一",
              "facebook" => "junichi.ito.717",
              "twitter" => "jnchito",
              "github" => nil
          },
          {
              "name" => "たいら",
              "facebook" => "app_scoped_user_id",
              "twitter" => "macha3k",
              "github" => "m-taira"
          }
      ]
    end

    example 'as hash' do
      event_url = 'https://nishiwaki-koberb.doorkeeper.jp/events/24544'
      VCR.use_cassette 'doorkeeper_events/24544_test_code_discussion', match_requests_on: [:uri] do
        result = DoorkeeperApi.fetch_event_details(event_url)
        expect(result).to match expected
      end
    end

    example 'as mash' do
      event_url = 'https://nishiwaki-koberb.doorkeeper.jp/events/24544'
      VCR.use_cassette 'doorkeeper_events/24544_test_code_discussion', match_requests_on: [:uri] do
        result = DoorkeeperApi.fetch_event_details_as_mash(event_url)
        expect(result.status).to eq 'success'
        event = result.event
        expect(event.title).to eq "Rubyistのためのテストコード相談会 ～テストの書き方に悩んでいませんか？～"
        profiles = event.participant_profiles
        expect(profiles.size).to eq 14
        profile = profiles.first
        expect(profile.name).to eq "Yuji Shimoda"
        expect(profile.facebook).to be_nil
        expect(profile.twitter).to eq "yuji_shimoda"
        expect(profile.github).to eq "yuji-shimoda"
      end
    end

    example 'event id not found' do
      event_url = 'https://nishiwaki-koberb.doorkeeper.jp/events/24'
      VCR.use_cassette 'doorkeeper_events/24_not_found', match_requests_on: [:uri] do
        result = DoorkeeperApi.fetch_event_details_as_mash(event_url)
        expect(result.status).to eq 'not_found'
      end
    end

    example 'event page not found' do
      event_url = 'https://nishiwaki-koberb.doorkeeper.jp/events/1'
      VCR.use_cassette 'doorkeeper_events/1_not_found', match_requests_on: [:uri] do
        result = DoorkeeperApi.fetch_event_details_as_mash(event_url)
        expect(result.status).to eq 'not_found'
      end
    end

    example 'unexpected error' do
      event_url = nil
      result = DoorkeeperApi.fetch_event_details_as_mash(event_url)
      expect(result.status).to match /ERROR/
    end
  end
end
