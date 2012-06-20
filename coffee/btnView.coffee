exports.btnView = ()->
  self = Ti.UI.createView()
  self.height = 50
  self.top = 0
  self.backgroundColor = 'blue'
  
  btnShow = Ti.UI.createButton()
  btnShow.title = 'show'
  btnShow.width = 50
  btnShow.height = 20
  btnShow.left = 10
  btnShow.addEventListener 'click',()->
    Ti.API.info "btnShow clicked"
    tblView.show()
  self.add btnShow
  
  btnHide = Ti.UI.createButton()
  btnHide.title = 'hide'
  btnHide.width = 50
  btnHide.height = 20
  btnHide.left = 70
  btnHide.addEventListener 'click',()->
    Ti.API.info "btnHide clicked"
    tblView.hide()
  self.add btnHide
  
  btnWeb = Ti.UI.createButton()
  btnWeb.title = 'Web'
  btnWeb.width = 50
  btnWeb.height = 20
  btnWeb.left = 130
  btnWeb.addEventListener 'click',()->
    Ti.API.info "btnWeb clicked"
    webView.zIndex = 30
    webView.updateHtml '<html><body>Test!</body></html>'
    webView.show()
  self.add btnWeb
  
  return self


