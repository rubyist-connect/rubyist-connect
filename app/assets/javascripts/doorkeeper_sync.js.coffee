$ ->
  # Buttonの有効無効制御に関する処理
  do ->
    isDoorkeeperUrl = (url) ->
      regex = /https?:\/\/[^.]+\.doorkeeper\.jp\/events\/\d+/
      regex.test(url)

    changeSyncButtonEnabled = ->
      link = $('.link-doorkeeper-sync')
      urlField = $('.field-doorkeeper-event-url')
      link.toggleClass('disabled', !isDoorkeeperUrl(urlField.val()))

    $('.field-doorkeeper-event-url').on
      'input' : changeSyncButtonEnabled

    changeSyncButtonEnabled()

  # Doorkeeperの情報取得に関する処理
  do ->
    setDoorkeeperInfo =  (results) ->
      $('.event-name').val results.name
      $.each results.attendee_user_ids, ->
        $("#event_user_ids_#{this}").prop('checked', true)

    syncDoorkeeper = ->
      path = $(@).data().path
      eventUrl = $('.field-doorkeeper-event-url').val()
      $imgLoading = $('.img-loading')
      $imgLoading.show()

      $statusMessage = $('.doorkeeper-sync-status')
      $statusMessage.text('情報を取得しています...').removeClass('result-success result-error')
      $('.result-icon-success,.result-icon-error').hide()

      $.ajax
        url: "#{path}?event_url=#{eventUrl}"
        dataType: "json"
        success: (results) ->
          setDoorkeeperInfo(results)
          $statusMessage.text('情報を取得しました。').addClass('result-success')
          $('.result-icon-success').show()
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
          $('.result-icon-error').show()
          $imgLoading.hide()

    $('.link-doorkeeper-sync').on
      'click' : syncDoorkeeper
