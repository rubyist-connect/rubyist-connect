$ ->
  setDoorkeeperInfo =  (results) ->
    $('.event-name').val results.name
    $.each results.attendee_user_ids, ->
      $("#event_user_ids_#{this}").prop('checked', true)

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
