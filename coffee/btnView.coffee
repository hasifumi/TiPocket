exports.btnView = ()->
  self = Ti.UI.createView()# {{{
  self.height = 50
  self.top = 0
  self.backgroundColor = 'blue'# }}}
  
  btnWeb = Ti.UI.createButton()# {{{
  btnWeb.title = 'Web'
  btnWeb.width = 50
  btnWeb.height = 20
  btnWeb.left = 10
  btnWeb.addEventListener 'click',()->
    Ti.API.debug "btnWeb clicked"
    webView.zIndex = 30
    webView.updateHtml '<html><body>Test!</body></html>'
    webView.show()
  self.add btnWeb# }}}
  
  btnSet = Ti.UI.createButton()# {{{
  btnSet.title = 'Set'
  btnSet.width = 50
  btnSet.height = 20
  btnSet.left = 70
  btnSet.addEventListener 'click',()->
    Ti.API.debug "btnSet clicked"
    settingView.zIndex = 30
    settingView.show()
  self.add btnSet# }}}
  
  btnReload = Ti.UI.createButton()# {{{
  btnReload.title = 'Reload'
  btnReload.width = 70
  btnReload.height = 20
  btnReload.left = 130
  btnReload.addEventListener 'click',()->
    Ti.API.debug "btnReload clicked"
    tblView.setData = []
    loadLists()
  self.add btnReload# }}}

  return self


