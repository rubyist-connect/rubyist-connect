$ ->
  $('.control-new-user-notification-enabled').on 'change', ->
    if this.checked
      $('.form-group-email').fadeIn 'fast'
    else
      $('.form-group-email').fadeOut 'fast'
