require 'rails_helper'

describe DoorkeeperApi do
  describe '::fetch_event_details' do
    let(:expected) do
      {
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
              "banner" => "https://dzpp79ucibp5a.cloudfront.net/events_banners/24544_normal_1430425474_5227436224_aa52b49262_b.jpg",
              "description" => "<h2>普段抱えているテストコードのモヤモヤをスッキリさせましょう！</h2>\n\n<p>今回の勉強会のテーマは「テストコード」です。<br>\nテストコードに関する疑問や悩みをみんなで持ち寄り、みんなで解決します。</p>\n\n<p>たとえば、こんなことで悩んでいたりしませんか？</p>\n\n<ul>\n<li>テストコードは書いてるけど、独学なので自信がない</li>\n<li>外部サービスと連携する処理のテストコードの書き方が分からない</li>\n<li>みんなどこまで細かくテストケースを作ってるの？</li>\n<li>未経験者なのでテストを書くと言っても、そもそも何から始めたら良いのかわからない</li>\n<li>etc...</li>\n</ul>\n\n<p>こうした参加者のみなさんのお悩みをみんなで議論したり、経験者の知見を参考にしたりながら現実解を探していく勉強会です。</p>\n\n<p>Rubyのテストコードに関する疑問や相談であれば何でもOKですので、みなさんお気軽にご参加ください！</p>\n\n<p><small>Banner image: <a href=\"https://flic.kr/p/8XVYEL\">https://flic.kr/p/8XVYEL</a></small></p>\n\n<h2>懇親会もあります！</h2>\n\n<p>本編が終わったあとはビアバッシュ形式の懇親会（参加自由）もあります。<br>\nみんなで楽しくRubyに関する話題で盛り上がりましょう！</p>\n\n<p><img src=\"https://qiita-image-store.s3.amazonaws.com/0/7465/25a4a7ac-1155-e223-0ed6-a0f3b53bfefe.jpeg\" alt=\"16069215349_e0916216c8_c.jpg\" title=\"16069215349_e0916216c8_c.jpg\"></p>",
              "public_url" => "https://nishiwaki-koberb.doorkeeper.jp/events/24544",
              "participants" => 15,
              "waitlisted" => 0,
              "group" => {
                  "id" => 1145,
                  "name" => "西脇.rb & 神戸.rb",
                  "country_code" => "JP",
                  "logo" => "https://dzpp79ucibp5a.cloudfront.net/groups_logos/1145_normal_1371633191_nshgrb-doorkeeper.jpeg",
                  "description" => "<p><img src=\"http://f.st-hatena.com/images/fotolife/J/JunichiIto/20141128/20141128201033.jpg\" alt=\"Members\"></p>\n\n<p>西脇〜神戸近辺のRubyistのためのグループです。</p>\n\n<p>西脇.rbの代表は<a href=\"https://twitter.com/jnchito\">伊藤淳一(@jnchito)</a>、神戸.rbの代表は<a href=\"https://twitter.com/spring_aki\">Aki(@spring_aki)</a>です。</p>\n\n<p>まだどちらのグループも小さいため、当面の間は合同で活動していきます。</p>\n\n<h3>Doorkeeperのメンバー登録に申込むと何が起きますか？</h3>\n\n<p>新しいイベントの開催通知をメールでお知らせします！<br>\nなので、西脇.rb &amp; 神戸.rbのイベントをいち早くキャッチしたいという方はお気軽にご登録を♪</p>\n\n<h3>FacebookやTwitterもやってます</h3>\n\n<p>コミュニティの最新情報や勉強会の追加情報などをお知らせしています。</p>\n\n<ul>\n<li><a href=\"https://www.facebook.com/nshgrb\">Facebookページ</a></li>\n<li><a href=\"https://twitter.com/nshgrb\">Twitter</a></li>\n</ul>\n\n<h3>活動記録やもくもく会FAQ等はこちら</h3>\n\n<p>これまでの活動記録やもくもく会FAQなどをこちらのWikiページにまとめていっています。</p>\n\n<ul>\n<li><a href=\"https://github.com/nishiwaki-higashinadarb/meetup/wiki\">Wiki</a></li>\n</ul>\n\n<h3>なぜ「西脇.rb &amp; 神戸.rb」を作ったの？</h3>\n\n<p>西脇.rb &amp; 神戸.rb (東灘.rb) 発足の経緯はこちらをご覧下さい。<br>\n※ 2014.07 に東灘.rb は神戸.rbに名称変更リファクタリングしました !!</p>\n\n<ul>\n<li><a href=\"http://blog.jnito.com/entry/2013/02/10/074617\">DevLOVE関西「勉強会勉強会」に参加しました #DevKan - give IT a try</a></li>\n<li><a href=\"http://spring-aki.com/archives/2830\">Akt One. » 勉強会勉強会に参加してきました。DevLOVE関西 #DevKan #DevLove</a></li>\n</ul>\n\n<h3>「Everyday Rails - RSpecによるRailsテスト入門」を翻訳しました</h3>\n\n<p>西脇.rb &amp; 神戸.rbの代表、<a href=\"https://twitter.com/jnchito\">伊藤淳一(@jnchito)</a>と<a href=\"https://twitter.com/spring_aki\">Aki(@spring_aki)</a>が翻訳した「<a href=\"https://leanpub.com/everydayrailsrspec-jp\">Everyday Rails - RSpecによるRailsテスト入門</a>」が<a href=\"https://leanpub.com\">Leanpub</a>より発売されています。<br>\nテストの自動化に興味のある方はぜひご購入下さい。もちろん、勉強会で本書の内容について質問してもらうのも大歓迎です！</p>\n\n<p>　</p>\n\n<p><a href=\"https://leanpub.com/everydayrailsrspec-jp\">Everyday Rails - RSpecによるRailsテスト入門</a></p>\n\n<table border=\"1\">\n<tbody><tr><td>\n<a href=\"https://leanpub.com/everydayrailsrspec-jp\"><img src=\"https://s3.amazonaws.com/titlepages.leanpub.com/everydayrailsrspec-jp/large\" style=\"border: solid 1px #ccc\"></a>\n</td></tr>\n</tbody></table>\n",
                  "public_url" => "https://nishiwaki-koberb.doorkeeper.jp/"
              },
              "participant_profiles" => expected_profiles,
          }
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
              "facebook" => "yuyakato1984",
              "twitter" => "nayutaya",
              "github" => "nayutaya"
          },
          {
              "name" => "原孝道",
              "facebook" => "takamichi.hara",
              "twitter" => nil,
              "github" => nil
          },
          {
              "name" => "Takahiro YAOTA (YuZakuro)",
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
              "facebook" => "kntmrkm",
              "twitter" => "kntmrkm",
              "github" => "kntmrkm"
          },
          {
              "name" => "knmsyk (こうの)",
              "facebook" => nil,
              "twitter" => "knmsyk",
              "github" => "knmsyk"
          },
          {
              "name" => "寺田 大輔",
              "facebook" => "aq2bq",
              "twitter" => "aq2bq",
              "github" => "aq2bq"
          },
          {
              "name" => "荻 竜也",
              "facebook" => "tatsuya.ogi",
              "twitter" => "t_oginogin",
              "github" => "t-oginogin"
          },
          {
              "name" => "やましー",
              "facebook" => "100008277219454",
              "twitter" => nil,
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

    example do
      event_id = '24544'
      VCR.use_cassette 'models/doorkeeper_api_spec/fetch_event_details' do
        result = DoorkeeperApi.fetch_event_details(event_id)
        expect(result).to match expected
      end
    end
  end
end