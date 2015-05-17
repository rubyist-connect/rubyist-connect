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
      $statusMessage.text('情報を取得しています...').removeClass('result-success result-error')

      $.ajax
        url: "#{path}?event_url=#{event_url}"
        dataType: "json"
        success: (results) ->
          setDoorkeeperInfo(results)
          $statusMessage.text('情報を取得しました。').addClass('result-success')
          $imgLoading.hide()
        error: (XMLHttpRequest, textStatus, errorThrown) ->
          switch XMLHttpRequest.status
            when 404
              $statusMessage.text('イベントが見つかりません。URLを確認してください。')
            else
              console.log("XMLHttpRequest: #{XMLHttpRequest.status}")
              console.log("textStatus: #{textStatus}")
              console.log("errorThrown: #{errorThrown}")
              $statusMessage.text('エラーが発生しました。しばらく経ってから再度実行してください。')
          $statusMessage.addClass('result-error')
          $imgLoading.hide()

    $('.link-doorkeeper-sync').on
      'click' : syncDoorkeeper
