$ ->
  $('.user-filter').on 'input', ->
    if filter = $('input.user-filter').val()
      $.each $('.user'), ->
        if ~$(this).data('filter-key').indexOf(filter)
          $(this).show()
        else
          $(this).hide()
    else
      $('.user').show()
