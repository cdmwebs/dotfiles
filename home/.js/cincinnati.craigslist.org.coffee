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
    markup = '<span class="search"> |
                <label for="result-search">Filter</label>
                <input type="text" name="result-search" id="result-search" />
              </span>'
    $("blockquote div").first().append(markup)

  formatSearch = ->
    tocpix = $('#tocpix')
    sortDiv = tocpix.siblings('div').first()
    sortDiv.css(float: 'right')
    tocpix.css(float: 'left')
    $('blockquote').eq(1).html($('blockquote').eq(1).html().replace(/&nbsp;/g, ''))
    $('h4.ban').css(marginTop: '2em')

  addSearchField()
  formatSearch()

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


$('body').css
  fontFamily: 'Helvetica, sans-serif'
  fontSize: '1.0em'
  color: '#444'
