exports.PocketDB = (lists)->
  self = {}

  self.dbName = 'pocketdb'

  self.open = ()->
    self.db = Ti.Database.open self.dbName
    return

  self.close = ()->
    self.db.close()
    return

  self.addLists = (lists)->
    self.open()
    idx = 0
    for key,elm of lists
      Ti.API.info "key:"+key+", elm.item_id:"+elm.item_id+", elm.title:"+elm.title
      rows = self.db.execute 'SELECT * FROM lists where item_id = ?', elm.item_id
      Ti.API.debug "Found: "+rows.getRowCount()
      if rows.getRowCount() is 0
        res = self.db.execute 'INSERT INTO lists (item_id, title, url, time_updated, time_added, state) VALUES (?, ?, ?, ?, ?, ?)', elm.item_id, elm.title, elm.url, elm.time_updated, elm.time_added, elm.state
        idx += 1
        Ti.API.debug "Add to DB"+elm.title
    self.close()
    Ti.API.info "idx:"+idx
    return

  self.selectList = (item_id)->
    self.open()
    Ti.API.info "selected :"+self.db.execute('SELECT (title) FROM lists where item_id = ?', item_id)
    self.close()
    return

  self.getSavedLists = ()->
    Ti.API.info "getSavedLists start"
    self.open()
    rows = self.db.execute('SELECT * FROM lists')
    Ti.API.info "count:"+rows.getRowCount()
    res = []
    if rows.getRowCount() > 0 
      while rows.isValidRow()
        Ti.API.info "rows.fieldByName('title'):"+rows.fieldByName('title')
        rows.next()
    rows.close()
    self.close()
    return res

  self.open()
  self.db.execute 'CREATE TABLE IF NOT EXISTS lists (item_id TEXT, title TEXT, url TEXT, time_updated TEXT, time_added TEXT, state TEXT)'
  Ti.API.info "table lists created"
  self.close()

  return self

  #for key,elm of timeline.list
  #  idx += 1
  #  #Ti.API.info "key:"+key+",elm.title="+elm.title
  #  row = Ti.UI.createTableViewRow()
  #  label = Ti.UI.createLabel()
  #  Ti.API.info "elm.title="+elm.title
  #  label.text = elm.title
  #  row.add label
  #  currentdata.push row
