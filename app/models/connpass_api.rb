class ConnpassApi < EventApi
  # Override
  def fetch_event_details(event_url)
    event_info = _fetch_event_info(event_url)
    if event_info.present?
      _doc_to_hash(event_info)
    else
      { 'status' => 'not_found' }
    end
  end

  private

  def _fetch_event_info(event_url)
    event_id = event_url[/(?<=event\/)\d+/]
    url = "http://connpass.com/event/#{event_id}/participation/"
    _logger.info "[INFO] Reading #{url}"
    uri = URI.parse(url)
    response = Net::HTTP.get_response(uri)
    case response.code
      when '200'
        Nokogiri::HTML.parse(response.body)
      when '404'
        nil
      else
        raise "Could not get event details: #{response.inspect}"
    end
  end

  def _doc_to_hash(doc)
    info = {
        'status' => 'success',
        'event' => {
            'title' => doc.css('.event_title').text,
            'participant_profiles' => []
        }
    }
    rows = doc.css('.applicant_area .participation_table_area .participants_table tbody tr')
    rows.each do |row|
      profile = { 'name' => nil, 'facebook' => nil, 'twitter' => nil, 'github' => nil }
      name = row.css('.user .display_name a')[0].text
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
      info['event']['participant_profiles'] << profile
    end
    info
  end
end
