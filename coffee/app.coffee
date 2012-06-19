win = Ti.UI.createWindow()
win.title = 'window'
win.backgroundColor = 'black'

BtnView = require('btnView').btnView
btnView = new BtnView()
win.add btnView

data = []
tblView = Ti.UI.createTableView()
tblView.data = data
tblView.top = 50
  
PocketDB = require('PocketDB').PocketDB
pocketDb = new PocketDB()
pocketDb.getRowCount()
#pocketDb.deleteLists()
#pocketDb.getRowCount()

updateLists = ()->
  currentdata = []
  currentLists = pocketDb.getSavedLists()
  Ti.API.info "currentLists.length:"+currentLists.length
  idx_i = 0
  for i in currentLists
    Ti.API.info "#{idx_i}.title:"+i.title
    Ti.API.info "#{idx_i}.time_updated:"+i.time_updated
    Ti.API.info "#{idx_i}.time_added:"+i.time_added
    idx_i += 1
    row = Ti.UI.createTableViewRow()
    label_title = Ti.UI.createLabel()
    label_title.text = i.title
    row.add label_title
    currentdata.push row
  tblView.setData currentdata
  return
  #for key,elm of timeline.list
  #  #Ti.API.info "key:"+key+",elm.title="+elm.title
  #  row = Ti.UI.createTableViewRow()
  #  label = Ti.UI.createLabel()
  #  label.text = elm.title
  #  row.add label
  #  currentdata.push row
  #tblView.setData currentdata

  #updateTimeLine = (timeline)->
  #  currentdata = []
  #  for key,elm of timeline.list
  #    #Ti.API.info "key:"+key+",elm.title="+elm.title
  #    row = Ti.UI.createTableViewRow()
  #    label = Ti.UI.createLabel()
  #    label.text = elm.title
  #    row.add label
  #    currentdata.push row
  #  tblView.setData currentdata
  #  pocketDb.addLists timeline.list
  #  pocketDb.getSavedLists()

xhr = Ti.Network.createHTTPClient()
user = 'fumi_hs'
orignal_url = "https://readitlaterlist.com/v2/"
get_param = "get?"
username_param = "username="
password_param = "&password="
apikey_param = "&apikey="
since_param = "&since="
count_param = "&count="
username = "hasifumi"
password = "emudisha"
apikey = "14bg3L7ap8377O4d51Ta4d3k49A6Xd2f"
since = "20120401"
count = "5"
url = orignal_url+get_param+username_param+username+password_param+password+apikey_param+apikey+since_param+since+count_param+count
#Ti.API.info "url="+url
xhr.open 'GET', url
xhr.onload = ()->
  #Ti.API.info this.responseText
  #timeline = JSON.parse this.responseText
  #updateTimeLine timeline
  lists = JSON.parse this.responseText
  pocketDb.addLists lists.list
  updateLists()
  return
xhr.send()

win.add tblView

win.open()



