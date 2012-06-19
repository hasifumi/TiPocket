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
      #Ti.API.info "key:"+key+", elm.item_id:"+elm.item_id+", elm.title:"+elm.title
      rows = self.db.execute 'SELECT * FROM lists where item_id = ?', elm.item_id
      #Ti.API.debug "Found: "+rows.getRowCount()
      if rows.getRowCount() is 0
        res = self.db.execute 'INSERT INTO lists (item_id, title, url, time_updated, time_added, state) VALUES (?, ?, ?, ?, ?, ?)', elm.item_id, elm.title, elm.url, elm.time_updated, elm.time_added, elm.state
        idx += 1
        #Ti.API.debug "Add to DB"+elm.title
    self.close()
    #Ti.API.info "idx:"+idx
    return

  self.getRowCount = ()->
    self.open()
    rows = self.db.execute 'SELECT * FROM lists'
    #Ti.API.info "getRowCount rowsCount:"+rows.getRowCount()
    self.close()
    return

  self.selectList = (item_id)->
    self.open()
    Ti.API.info "selected :"+self.db.execute('SELECT (title) FROM lists where item_id = ?', item_id)
    self.close()
    return

  self.getSavedLists = ()->
    Ti.API.info "getSavedLists start"
    self.open()
    #rows = self.db.execute('SELECT * FROM lists')
    rows = self.db.execute('SELECT * FROM lists order by time_updated desc')
    Ti.API.info "count:"+rows.getRowCount()
    res = []
    if rows.getRowCount() > 0 
      while rows.isValidRow()
        #Ti.API.info "rows.fieldByName('item_id'):"+rows.fieldByName('item_id')
        #Ti.API.info "rows.fieldByName('title'):"+rows.fieldByName('title')
        #Ti.API.info "rows.fieldByName('url'):"+rows.fieldByName('url')
        #Ti.API.info "rows.fieldByName('time_updated'):"+rows.fieldByName('time_updated')
        #Ti.API.info "rows.fieldByName('time_added'):"+rows.fieldByName('time_added')
        #Ti.API.info "rows.fieldByName('state'):"+rows.fieldByName('state')
        res1 = {}
        res1.item_id      = rows.fieldByName('item_id')
        res1.title        = rows.fieldByName('title')
        res1.url          = rows.fieldByName('url')
        res1.time_updated = rows.fieldByName('time_updated')
        res1.time_added   = rows.fieldByName('time_added')
        res1.state        = rows.fieldByName('state')
        res.push res1
        rows.next()
    rows.close()
    Ti.API.info "res.length:"+res.length
    self.close()
    return res

  self.deleteLists = ()->
    self.open()
    self.db.execute('DELETE FROM lists')
    self.close()
    Ti.API.info "delete from lists"
    return

  self.open()
  self.db.execute 'CREATE TABLE IF NOT EXISTS lists (item_id TEXT, title TEXT, url TEXT, time_updated TEXT, time_added TEXT, state TEXT)'
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

