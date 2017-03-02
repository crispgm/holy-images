$ ->
  $("a[data-remote]").on "ajax:success", (e, data, status, xhr) ->
    alert "Liked."