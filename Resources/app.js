var data, tblView, updateTimeLine, url, user, win, xhr;
win = Ti.UI.createWindow();
win.title = 'window';
win.backgroundColor = 'black';
data = [];
tblView = Ti.UI.createTableView();
tblView.data = data;
updateTimeLine = function(timeline) {
  var currentdata, j, label, row, _i, _len;
  currentdata = [];
  for (_i = 0, _len = timeline.length; _i < _len; _i++) {
    j = timeline[_i];
    row = Ti.UI.createTableViewRow();
    label = Ti.UI.createLabel();
    label.text = j.text;
    row.add(label);
    currentdata.push(row);
  }
  return tblView.setData(currentdata);
};
xhr = Ti.Network.createHTTPClient();
user = 'fumi_hs';
url = "http://api.twitter.com/1/statuses/user_timeline.json?screen_name=" + user;
xhr.open('GET', url);
xhr.onload = function() {
  var timeline;
  timeline = JSON.parse(this.responseText);
  updateTimeLine(timeline);
};
xhr.send();
win.add(tblView);
win.open();