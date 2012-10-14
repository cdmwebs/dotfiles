if window.location.pathname == '/2.6/ledger.html' || window.location.pathname == '/3.0/doc/ledger3.html'
  body = $('body')
  body.css display: 'none'

  content = body.html()
      
  body.html('').append('<div id="container"></div>')
  container = $('#container')
  container.html(content)

  body.css
    backgroundColor: '#666'
    color: '#333'
    font: '14px/21px Helvetica, sans-serif'

  container.css
    maxWidth: '720px'
    margin: '2em auto'
    backgroundColor: '#fff'
    padding: '1.5em 3em'
    border: '1px solid #888'

  $('pre').css
    padding: '1em 0'
    backgroundColor: '#232323'
    color: '#11CC00'
    font: '14px/22px Inconsolota, Menlo'
    borderRadius: '3px'

  $('h1, h2, h3, h4, h5').css
    textShadow: '1px 1px 1px #ccc'

  $('a').css
    color: '#3366CC'
    fontWeight: 'bold'
    textDecoration: 'none'

  $('a').hover(
    (e) -> $(e.target).css textDecoration: 'underline'
    (e) -> $(e.target).css textDecoration: 'none')

  $('hr').css
    display: 'block'
    position: 'relative'
    padding: '0'
    margin: '8px auto'
    width: '100%'
    clear: 'both'
    border: 'none'
    borderTop: '1px solid #AAA'
    borderBottom: '1px solid #FFF'
    fontSize: '1px'
    lineHeight: '0'
    overflow: 'visible'

  body.fadeIn()
