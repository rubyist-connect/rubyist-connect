$ ->
  setDoorkeeperInfo =  (results) ->
    $('.event-name').val results.name

  syncDoorkeeper = ->
    path = $(@).data().path

    $.ajax
      url: path
      dataType: "json"
      success: (results) ->
        setDoorkeeperInfo(results)

  $('.link-doorkeeper-sync').on
    'click' : syncDoorkeeper
