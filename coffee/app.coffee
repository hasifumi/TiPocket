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

updateTimeLine = (timeline)->
  currentdata = []
  for key,elm of timeline.list
    #Ti.API.info "key:"+key+",elm.title="+elm.title
    row = Ti.UI.createTableViewRow()
    label = Ti.UI.createLabel()
    label.text = elm.title
    row.add label
    currentdata.push row
  tblView.setData currentdata
  pocketDb.addLists timeline.list
  pocketDb.getSavedLists()

xhr = Ti.Network.createHTTPClient()
user = 'fumi_hs'
orignal_url = "https://readitlaterlist.com/v2/"
get_param = "get?"
username_param = "username="
password_param = "&password="
apikey_param = "&apikey="
since_param = "&since="
count_param = "&count="
username = ""
password = ""
apikey = "14bg3L7ap8377O4d51Ta4d3k49A6Xd2f"
since = "20120401"
count = "20"
url = orignal_url+get_param+username_param+username+password_param+password+apikey_param+apikey+since_param+since+count_param+count
#Ti.API.info "url="+url
xhr.open 'GET', url
xhr.onload = ()->
  #Ti.API.info this.responseText
  timeline = JSON.parse this.responseText
  updateTimeLine timeline
  return
xhr.send()

win.add tblView

win.open()



