$ ->
  $("#user-operations>div>a").on "ajax:success", (e, data, status, xhr) ->
    window.location.href = "/"
