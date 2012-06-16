win = Ti.UI.createWindow()
win.title = 'window'
win.backgroundColor = 'black'

data = []
tblView = Ti.UI.createTableView()
tblView.data = data
  
updateTimeLine = (timeline)->
  #Ti.API.info "updateTimeLine func start"
  #Ti.API.info "timeline length ="+timeline.length
  currentdata = []
  for j in timeline
    row = Ti.UI.createTableViewRow()
    label = Ti.UI.createLabel()
    #Ti.API.info "j.text = "+j.text
    label.text = j.text
    row.add label
    currentdata.push row
  tblView.setData currentdata

xhr = Ti.Network.createHTTPClient()
user = 'fumi_hs'
url = "http://api.twitter.com/1/statuses/user_timeline.json?screen_name="+user
xhr.open 'GET', url
xhr.onload = ()->
  #Ti.API.info this.responseText
  timeline = JSON.parse this.responseText
  updateTimeLine timeline
  return
xhr.send()

win.add tblView

win.open()



