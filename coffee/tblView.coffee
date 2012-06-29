exports.tblView = ()->
  self = Ti.UI.createTableView()
  data = []
  self.data = data
  self.top = 50
  self.zIndex = 20
  self.addEventListener 'click',(e)-># {{{
    Ti.API.debug "e.row.item_id="+e.row.item_id
    res = pocketDb.getSavedHtml e.row.item_id
    webView.html = ""
    webView.updateHtml res
    webView.zIndex = 30
    webView.show()# }}}# }}}

  return self


