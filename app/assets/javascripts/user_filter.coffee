$ ->
  $('.user-filter').on 'input', ->
    if filter = $('input.user-filter').val().toLowerCase()
      $.each $('.user'), ->
        targetElement = $(this)
        userName = targetElement.data('filter-key').toLowerCase()
        if ~userName.indexOf(filter)
          targetElement.show()
        else
          targetElement.hide()
    else
      $('.user').show()
