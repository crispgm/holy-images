$ ->
  $("a[data-remote].image-like").on "ajax:success", (e, data, status, xhr) ->
    image_html_id = $(this).attr("id")
    image_id = image_html_id.split("-")[2]
    if data.status == 0
      $("#image-like-#{image_id}>i").attr("class", "fa fa-heart")
      $("#like-count-#{image_id}").text(data.cur_num)
    else if data.status == 1
      $("#image-like-#{image_id}>i").attr("class", "fa fa-heart-o")
      $("#like-count-#{image_id}").text(data.cur_num)
    else
      alert "点赞出错了！服务器说自己有病：#{data.status}"
