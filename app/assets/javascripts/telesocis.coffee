$ ->
  $(".telesoci-list[data-link]").on 'click', ->
    window.location = $(this).data('link')
