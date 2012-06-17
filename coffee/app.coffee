win = Ti.UI.createWindow()
win.title = 'window'
win.backgroundColor = 'black'

#btnView = Ti.UI.createView()
#btnView.height = 50
#btnView.top = 0
#btnView.backgroundColor = 'blue'
#
#btnShow = Ti.UI.createButton()
#btnShow.title = 'show'
#btnShow.width = 50
#btnShow.height = 20
#btnShow.left = 10
#btnShow.addEventListener 'click',()->
#  Ti.API.info "btnShow clicked"
#  tblView.show()
#btnView.add btnShow
#
#btnHide = Ti.UI.createButton()
#btnHide.title = 'hide'
#btnHide.width = 50
#btnHide.height = 20
#btnHide.left = 70
#btnHide.addEventListener 'click',()->
#  Ti.API.info "btnHide clicked"
#  tblView.hide()
#btnView.add btnHide

BtnView = require('btnView').btnView
btnView = new BtnView()
win.add btnView

data = []
tblView = Ti.UI.createTableView()
tblView.data = data
tblView.top = 50
  
updateTimeLine = (timeline)->
  Ti.API.info "updateTimeLine func start"
  Ti.API.info 'timeline.list["177866339"].item_id ='+timeline.list["177866339"].item_id
  currentdata = []
  idx = 0
  for key,elm of timeline.list
    idx += 1
    #Ti.API.info "key:"+key+",elm.title="+elm.title
    row = Ti.UI.createTableViewRow()
    label = Ti.UI.createLabel()
    Ti.API.info "elm.title="+elm.title
    label.text = elm.title
    row.add label
    currentdata.push row
  Ti.API.info "idx="+idx
  tblView.setData currentdata

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
count = "20"
url = orignal_url+get_param+username_param+username+password_param+password+apikey_param+apikey+since_param+since+count_param+count
Ti.API.info "url="+url
xhr.open 'GET', url
xhr.onload = ()->
  #Ti.API.info this.responseText
  timeline = JSON.parse this.responseText
  updateTimeLine timeline
  return
xhr.send()

win.add tblView

win.open()



