exports.PocketDB = function(lists) {
  var self;
  self = {};
  self.dbName = 'pocketdb';
  self.open = function() {
    self.db = Ti.Database.open(self.dbName);
  };
  self.close = function() {
    self.db.close();
  };
  self.getUrlSource = function(url) {
    var xhr;
    xhr = Ti.Network.createHTTPClient();
    xhr.open('GET', url);
    xhr.onerror = function() {
      Ti.API.info("getUrlSource onerror, url:" + url);
    };
    xhr.onload = function() {
      return this.responseText;
    };
    xhr.send();
  };
  self.addLists = function(lists) {
    var elm, idx, key, res, rows;
    self.open();
    idx = 0;
    for (key in lists) {
      elm = lists[key];
      rows = self.db.execute('SELECT * FROM lists where item_id = ?', elm.item_id);
      if (rows.getRowCount() === 0) {
        res = self.db.execute('INSERT INTO lists (item_id, title, url, time_updated, time_added, state) VALUES (?, ?, ?, ?, ?, ?)', elm.item_id, elm.title, elm.url, elm.time_updated, elm.time_added, elm.state);
        idx += 1;
      }
    }
    self.close();
  };
  self.getRowCount = function() {
    var rows;
    self.open();
    rows = self.db.execute('SELECT * FROM lists');
    self.close();
  };
  self.selectList = function(item_id) {
    self.open();
    Ti.API.info("selected :" + self.db.execute('SELECT (title) FROM lists where item_id = ?', item_id));
    self.close();
  };
  self.getSavedLists = function() {
    var res, res1, rows;
    Ti.API.info("getSavedLists start");
    self.open();
    rows = self.db.execute('SELECT * FROM lists order by time_updated desc');
    Ti.API.info("count:" + rows.getRowCount());
    res = [];
    if (rows.getRowCount() > 0) {
      while (rows.isValidRow()) {
        res1 = {};
        res1.item_id = rows.fieldByName('item_id');
        res1.title = rows.fieldByName('title');
        res1.url = rows.fieldByName('url');
        res1.time_updated = rows.fieldByName('time_updated');
        res1.time_added = rows.fieldByName('time_added');
        res1.state = rows.fieldByName('state');
        res.push(res1);
        rows.next();
      }
    }
    rows.close();
    Ti.API.info("res.length:" + res.length);
    self.close();
    return res;
  };
  self.deleteLists = function() {
    self.open();
    self.db.execute('DELETE FROM lists');
    self.close();
    Ti.API.info("delete from lists");
  };
  self.open();
  self.db.execute('CREATE TABLE IF NOT EXISTS lists (item_id TEXT, title TEXT, url TEXT, time_updated TEXT, time_added TEXT, state TEXT)');
  self.close();
  return self;
};