$ ->
  $("a[data-remote]").on "ajax:success", (e, data, status, xhr) ->
    window.reload