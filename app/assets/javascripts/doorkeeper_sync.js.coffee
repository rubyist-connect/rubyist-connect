$ ->
  setDoorkeeperInfo =  (results) ->
    $('.event-name').val results.name

  syncDoorkeeper = ->
    path = $(@).data().path
    event_url = $('.doorkeeper-event-url').val()

    $.ajax
      url: "#{path}?event_url=#{event_url}"
      dataType: "json"
      success: (results) ->
        setDoorkeeperInfo(results)

  $('.link-doorkeeper-sync').on
    'click' : syncDoorkeeper
