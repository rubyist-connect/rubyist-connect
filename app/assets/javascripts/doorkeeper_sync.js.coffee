$ ->
  isDoorkeeperUrl = (url) ->
    regex = /https:\/\/[^.]+\.doorkeeper\.jp\/events\/\d+/
    regex.test(url)

  changeSyncButtonEnabled = ->
    link = $('.link-doorkeeper-sync')
    urlField = $('.field-doorkeeper-event-url')
    link.toggleClass('disabled', !isDoorkeeperUrl(urlField.val()))

  changeSyncButtonEnabled()

  $('.field-doorkeeper-event-url').on
    'change' : changeSyncButtonEnabled

  do ->
    setDoorkeeperInfo =  (results) ->
      $('.event-name').val results.name
      $.each results.attendee_user_ids, ->
        $("#event_user_ids_#{this}").prop('checked', true)

    syncDoorkeeper = ->
      path = $(@).data().path
      event_url = $('.field-doorkeeper-event-url').val()
      $('.img-loading').show()

      $.ajax
        url: "#{path}?event_url=#{event_url}"
        dataType: "json"
        success: (results) ->
          setDoorkeeperInfo(results)
          $('.img-loading').hide()
        error: (XMLHttpRequest, textStatus, errorThrown) ->
          console.error("Error occurred in replaceChildrenOptions")
          console.log("XMLHttpRequest: #{XMLHttpRequest.status}")
          console.log("textStatus: #{textStatus}")
          console.log("errorThrown: #{errorThrown}")
          $('.img-loading').hide()

    $('.link-doorkeeper-sync').on
      'click' : syncDoorkeeper
