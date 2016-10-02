$ ->
  # Buttonの有効無効制御に関する処理
  do ->
    isEventUrl = (url) ->
      dk_regex = /https?:\/\/[^.]+\.doorkeeper\.jp\/events\/\d+/
      cp_regex = /https?:\/\/(?:[^.]+\.)?connpass\.com\/event\/\d+/
      dk_regex.test(url) || cp_regex.test(url)

    changeSyncButtonEnabled = ->
      link = $('.link-event-sync')
      urlField = $('.field-event-url')
      link.toggleClass('disabled', !isEventUrl(urlField.val()))

    $('.field-event-url').on 'input', changeSyncButtonEnabled

    changeSyncButtonEnabled()

  # Eventの情報取得に関する処理
  do ->
    setEventInfo =  (results) ->
      $('.event-name').val results.name
      $.each results.attendee_user_ids, ->
        $("#event_user_ids_#{this}").prop('checked', true)

    syncEvent = ->
      path = $(@).data().path
      eventUrl = $('.field-event-url').val()
      $imgLoading = $('.img-loading')
      $imgLoading.show()

      $statusMessage = $('.event-sync-status')
      $statusMessage.text('情報を取得しています...').removeClass('result-success result-error')
      $('.result-icon-success,.result-icon-error').hide()

      $.ajax
        url: "#{path}?event_url=#{eventUrl}"
        dataType: "json"
        success: (results) ->
          setEventInfo(results)
          $statusMessage.text('情報を取得しました。').addClass('result-success')
          $('.result-icon-success').show()
          $imgLoading.hide()
        error: (XMLHttpRequest, textStatus, errorThrown) ->
          switch XMLHttpRequest.status
            when 404
              $statusMessage.text('イベントが見つかりません。URLを確認してください。')
            else
              $statusMessage.text('エラーが発生しました。しばらく経ってから再度実行してください。')
          $statusMessage.addClass('result-error')
          $('.result-icon-error').show()
          $imgLoading.hide()

    $('.link-event-sync').on 'click', syncEvent
