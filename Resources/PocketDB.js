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
  self.addLists = function(lists) {
    var elm, idx, key, res, rows;
    self.open();
    idx = 0;
    for (key in lists) {
      elm = lists[key];
      rows = self.db.execute('SELECT * FROM lists where item_id = ?', elm.item_id);
      if (rows.getRowCount() === 0) {
        res = self.db.execute('INSERT INTO lists (item_id, title, url, time_updated, time_added, state, read) VALUES (?, ?, ?, ?, ?, ?, ?)', elm.item_id, elm.title, elm.url, elm.time_updated, elm.time_added, elm.state, 'false');
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
    Ti.API.debug("selected :" + self.db.execute('SELECT (title) FROM lists where item_id = ?', item_id));
    self.close();
  };
  self.getSavedLists = function() {
    var res, res1, rows;
    Ti.API.debug("getSavedLists start");
    self.open();
    rows = self.db.execute('SELECT * FROM lists order by time_updated desc');
    Ti.API.debug("count:" + rows.getRowCount());
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
        res1.read = rows.fieldByName('read');
        res.push(res1);
        rows.next();
      }
    }
    rows.close();
    Ti.API.debug("res.length:" + res.length);
    self.close();
    return res;
  };
  self.deleteLists = function() {
    self.open();
    self.db.execute('DELETE FROM lists');
    self.close();
    Ti.API.debug("delete from lists");
  };
  self.readList = function(item_id) {
    self.open();
    self.db.execute("UPDATE lists set read = 'true' where item_id = ?", item_id);
    self.close();
    Ti.API.debug("read item_id:" + item_id);
  };
  self.unreadList = function(item_id) {
    self.open();
    self.db.execute("UPDATE lists set read = 'false' where item_id = ?", item_id);
    self.close();
    Ti.API.debug("unread item_id:" + item_id);
  };
  self.getUrlSource = function(item_id, url) {
    var url_instapaper, xhr;
    Ti.API.debug("self.getUrlSource start item_id:" + item_id + ", url:" + url);
    xhr = Ti.Network.createHTTPClient();
    url_instapaper = "http://www.instapaper.com/m?u=" + url;
    xhr.open('GET', url_instapaper);
    xhr.onload = function() {
      var html, res, rows1;
      html = this.responseText;
      self.open();
      rows1 = self.db.execute('SELECT * FROM htmls where item_id = ?', item_id);
      Ti.API.debug("self.getUrlSource select from htmls Count:" + rows1.getRowCount());
      if (rows1.getRowCount() === 0) {
        res = self.db.execute('INSERT INTO htmls (item_id, html) VALUES (?, ?)', item_id, html);
        Ti.API.debug("getUrlSource insert html, item_id:" + item_id);
      }
      rows1.close();
      self.close();
    };
    xhr.send();
  };
  self.addHtmls = function() {
    var item_id, rows, url;
    self.open();
    rows = self.db.execute('SELECT * FROM lists');
    Ti.API.debug("self.addHtmls select form lists Count:" + rows.getRowCount());
    if (rows.getRowCount() > 0) {
      while (rows.isValidRow()) {
        item_id = rows.fieldByName('item_id');
        url = rows.fieldByName('url');
        self.getUrlSource(item_id, url);
        rows.next();
      }
    }
    rows.close();
    return self.close();
  };
  self.getSavedHtml = function(item_id) {
    var res, rows;
    if (item_id === null) {
      return;
    }
    Ti.API.debug("getSavedHtmls start");
    self.open();
    rows = self.db.execute('SELECT * FROM htmls where item_id = ?', item_id);
    Ti.API.debug("getSaveHtmls select item_id=" + item_id + ", count=" + rows.getRowCount());
    if (rows.getRowCount() === 1) {
      while (rows.isValidRow()) {
        res = rows.fieldByName('html');
        rows.next();
      }
    }
    rows.close();
    self.close();
    return res;
  };
  self.initialize = function() {
    self.open();
    self.db.execute('CREATE TABLE IF NOT EXISTS lists (item_id TEXT, title TEXT, url TEXT, time_updated TEXT, time_added TEXT, state TEXT, read TEXT)');
    self.db.execute('CREATE TABLE IF NOT EXISTS htmls (item_id TEXT, html BLOB)');
    return self.close();
  };
  self.initialize();
  return self;
};