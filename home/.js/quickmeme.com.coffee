if image = $('#img')
  imgUrl = image.attr('src')

  input = "<div class='linkShare'>"
  input += "<h4>Get the image URL</h4>"
  input += "<input type='text' value='#{imgUrl}' id='imgUrl' size='#{imgUrl?.length + 2}' />"
  input += "</div>"

  $('div.linkShare').first().before input
  $('#imgUrl').select()
