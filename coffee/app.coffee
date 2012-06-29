win = Ti.UI.createWindow()
win.title = 'window'
win.backgroundColor = 'black'
win.orientationModes = [# {{{
  Titanium.UI.PORTRAIT
  Titanium.UI.UPSIDE_PORTRAIT
  Titanium.UI.LANDSCAPE_LEFT
  Titanium.UI.LANDSCAPE_RIGHT
  Titanium.UI.FACE_UP
  Titanium.UI.FACE_DOWN
  Titanium.UI.UNKNOWN
]  # }}}

WebView = require('webView').webView# {{{
webView = new WebView()
webView.hide()
webView.zIndex = 10
win.add webView# }}}

SettingView = require('settingView').settingView# {{{
settingView = new SettingView()
settingView.hide()
settingView.zIndex = 10
win.add settingView# }}}

BtnView = require('btnView').btnView# {{{
btnView = new BtnView()
btnView.zIndex = 20
win.add btnView# }}}

tblView = Ti.UI.createTableView()# {{{
data = []
tblView.data = data
tblView.top = 50
tblView.zIndex = 20
tblView.addEventListener 'click',(e)-># {{{
  Ti.API.debug "e.row.item_id="+e.row.item_id
  res = pocketDb.getSavedHtml e.row.item_id
  webView.html = ""
  webView.updateHtml res
  webView.zIndex = 30
  webView.show()# }}}# }}}
  
PocketDB = require('PocketDB').PocketDB# {{{
pocketDb = new PocketDB()
pocketDb.getRowCount()
pocketDb.deleteLists()
pocketDb.getRowCount()# }}}

updateLists = ()-># {{{
  tblView.setData []
  currentdata = []
  currentLists = pocketDb.getSavedLists()
  Ti.API.debug "currentLists.length:"+currentLists.length
  idx_i = 0
  for i in currentLists
    Ti.API.debug "#{idx_i}.item_id:"+i.item_id
    Ti.API.debug "#{idx_i}.title:"+i.title
    #Ti.API.debug "#{idx_i}.url:"+i.url
    #pocketDb.getUrlSource i.url
    Ti.API.debug "#{idx_i}.time_updated:"+i.time_updated
    Ti.API.debug "#{idx_i}.time_added:"+i.time_added
    idx_i += 1
    row = Ti.UI.createTableViewRow()
    row.editable = true
    row.addEventListener 'click', (e)->
      Ti.API.debug "row clicked"
    label_title = Ti.UI.createLabel()
    label_title.text = i.title
    row.add label_title
    row.item_id = i.item_id
    #row.addEventListener 'click',(e)->
    #  webView.updateHtml e.rowData.html
    #  webView.zIndex = 30
    #  webView.show()
    currentdata.push row
  tblView.setData currentdata
  return
  #for key,elm of timeline.list
  #  #Ti.API.debug "key:"+key+",elm.title="+elm.title
  #  row = Ti.UI.createTableViewRow()
  #  label = Ti.UI.createLabel()
  #  label.text = elm.title
  #  row.add label
  #  currentdata.push row
  #tblView.setData currentdata# }}}

  #updateTimeLine = (timeline)-># {{{
  #  currentdata = []
  #  for key,elm of timeline.list
  #    #Ti.API.debug "key:"+key+",elm.title="+elm.title
  #    row = Ti.UI.createTableViewRow()
  #    label = Ti.UI.createLabel()
  #    label.text = elm.title
  #    row.add label
  #    currentdata.push row
  #  tblView.setData currentdata
  #  pocketDb.addLists timeline.list
  #  pocketDb.getSavedLists()# }}}

loadLists = ()-># {{{
  xhr = Ti.Network.createHTTPClient()
  orignal_url = "https://readitlaterlist.com/v2/"
  get_param = "get?"
  username_param = "username="
  password_param = "&password="
  apikey_param = "&apikey="
  since_param = "&since="
  count_param = "&count="
  username = Ti.App.Properties.getString 'username'
  password = Ti.App.Properties.getString 'password'
  Ti.API.debug "getString username:"+username
  Ti.API.debug "getString password:"+password
  apikey = "14bg3L7ap8377O4d51Ta4d3k49A6Xd2f"
  since = "20120401"
  count = "50"
  url = orignal_url+get_param+username_param+username+password_param+password+apikey_param+apikey+since_param+since+count_param+count
  #Ti.API.debug "url="+url
  #xhr.setRequestHeader 'User-Agent','Mozilla/5.0 (iPhone; U; CPU like Mac OS X; en) AppleWebKit/420+ (KHTML, like Gecko) Version/3.0 Mobile/1A537a Safari/419.3'
  xhr.setRequestHeader 'User-Agent','Mozilla/5.0 (Linux; U; Android 1.5; ja-jp; HT-03A Build/CDB72) AppleWebKit/528.5+ (KHTML, like Gecko) Version/3.1.2 Mobile Safari/525.20.1'
  xhr.open 'GET', url
  xhr.onload = ()->
    #Ti.API.debug this.responseText
    #timeline = JSON.parse this.responseText
    #updateTimeLine timeline
    lists = JSON.parse this.responseText
    pocketDb.addLists lists.list
    pocketDb.addHtmls()
    updateLists()
    return
  xhr.send()# }}}

#loadLists()
updateLists()

win.add tblView

win.open()

#Ti.API.debug "Network:"+Ti.Network.online
