if (window.location.pathname.match(/\/search\//) && !$('body').html().match(/Nothing found for that search/))
  searchHash     = window.location.hash
  searchString   = searchHash.split("/")[1]
  filterResults  = {}
  addSearchField = {}

  filterResults = (searchString) ->
    searchExpression = new RegExp(searchString, "gi")
    results = $("p.row")
    results.show().filter ->
      unless $(@).text().match(searchExpression)
        $(@).hide()

  addSearchField = ->
    markup = '| <label for = "result-search">Filter</label> <input type = "text" name = "result-search" id = "result-search" />'
    $("blockquote div").first().append(markup)

  addSearchField()

  if (searchString != "")
    filterResults(searchString)
    $('#result-search').val(searchString).focus()

  $("#result-search").live "keyup", ->
    searchString = $(this).val()
    filterResults(searchString)
    if (searchString != "")
      window.location.hash = "search/" + searchString
else
  $('#query').focus()
