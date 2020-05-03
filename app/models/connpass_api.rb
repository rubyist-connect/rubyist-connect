require 'httpclient'

class ConnpassApi < EventApi
  # Override
  def fetch_event_details(event_url)
    fetch_event_info(event_url)
  end

  private

  def fetch_event_info(event_url)
    base_url = event_url[/https?:\/\/(?:[^.]+\.)?connpass\.com\/event\/\d+/]
    url = "#{base_url}/participation/"
    logger.info "[INFO] Reading #{url}"
    cliennt = HTTPClient.new
    response = cliennt.get(url, follow_redirect: true)
    case response.code
      when 200
        { 'status' => :ok, 'event' => doc_to_hash(Nokogiri::HTML.parse(response.body)) }
      when 403
        { 'status' => :forbidden }
      when 404
        { 'status' => :not_found }
      else
        raise "Could not get event details: #{response.inspect}"
    end
  end

  def doc_to_hash(doc)
    event = {
      'title' => doc.css('.event_title').text,
      'participant_profiles' => []
    }
    rows = doc.css('.applicant_area .participation_table_area .participants_table tbody tr')
    rows.each do |row|
      name = row.css('.user .display_name a')[0]&.text
      next if name.blank?

      profile = { 'name' => nil, 'facebook' => nil, 'twitter' => nil, 'github' => nil }
      profile['name'] = name
      row.css('.social a').each do |link|
        href = link['href']
        if twitter = href[/(?<=screen_name=).*/]
          profile['twitter'] = twitter
        elsif facebook = href[/(?<=app_scoped_user_id\/)[^\/]+/]
          profile['facebook'] = facebook
        elsif github = href[/(?<=github.com\/)[^\/]+/]
          profile['github'] = github
        end
      end
      event['participant_profiles'] << profile
    end
    event
  end
end
