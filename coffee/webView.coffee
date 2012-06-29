exports.webView = ()->
  self = Ti.UI.createView()

  btnArea = Ti.UI.createView()# {{{
  btnArea.height = 50
  btnArea.backgroundColor = 'red'
  btnArea.top = 0
  self.add btnArea# }}}

  closeBtn = Ti.UI.createButton()# {{{
  closeBtn.title = "close"
  closeBtn.top = 10
  closeBtn.height = 20
  closeBtn.width = 50
  closeBtn.left = 10
  closeBtn.addEventListener 'click', ()->
    self.zIndex = 10
    self.hide()
    return
  btnArea.add closeBtn# }}}
  
  backBtn = Ti.UI.createButton()# {{{
  backBtn.title = "back"
  backBtn.top = 10
  backBtn.height = 20
  backBtn.width = 50
  backBtn.left = 70
  backBtn.addEventListener 'click', ()->
    if webView1.canGoBack()
      Ti.API.debug "webView1.goBack"
      webView1.goBack()
    return
  btnArea.add backBtn# }}}
  
  forwardBtn = Ti.UI.createButton()# {{{
  forwardBtn.title = "forward"
  forwardBtn.top = 10
  forwardBtn.height = 20
  forwardBtn.width = 70
  forwardBtn.left = 130
  forwardBtn.addEventListener 'click', ()->
    if webView1.canGoForward() 
      Ti.API.debug "webView1.goForward"
      webView1.goForward()
    return
  btnArea.add forwardBtn# }}}
  
  webView1 = Ti.UI.createWebView()# {{{
  webView1.top = 50
  webView1.backgroundColor = 'white'
  self.add webView1# }}}

  self.updateHtml = (html_src)-># {{{
    webView1.html = html_src
    return# }}}
  
  return self


