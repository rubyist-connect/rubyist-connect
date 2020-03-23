$ ->
  $('.user-filter').on 'input', ->
    if filter = $('input.user-filter').val()
      $.each $('.user'), ->
        if ~$(this).data('filter-key').toLowerCase().indexOf(filter.toLowerCase())
          $(this).show()
        else
          $(this).hide()
    else
      $('.user').show()
