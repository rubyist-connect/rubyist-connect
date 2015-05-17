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
    'input' : changeSyncButtonEnabled

  do ->
    setDoorkeeperInfo =  (results) ->
      $('.event-name').val results.name
      $.each results.attendee_user_ids, ->
        $("#event_user_ids_#{this}").prop('checked', true)

    syncDoorkeeper = ->
      path = $(@).data().path
      event_url = $('.field-doorkeeper-event-url').val()
      $imgLoading = $('.img-loading')
      $imgLoading.show()

      $statusMessage = $('.doorkeeper-sync-status')
      $statusMessage.text('情報を取得しています...')

      $.ajax
        url: "#{path}?event_url=#{event_url}"
        dataType: "json"
        success: (results) ->
          setDoorkeeperInfo(results)
          $statusMessage.text('情報を取得しました。')
          $imgLoading.hide()
        error: (XMLHttpRequest, textStatus, errorThrown) ->
          console.error("Error occurred in replaceChildrenOptions")
          console.log("XMLHttpRequest: #{XMLHttpRequest.status}")
          console.log("textStatus: #{textStatus}")
          console.log("errorThrown: #{errorThrown}")
          $imgLoading.hide()

    $('.link-doorkeeper-sync').on
      'click' : syncDoorkeeper
