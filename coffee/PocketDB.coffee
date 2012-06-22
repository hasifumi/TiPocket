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
      #Ti.API.debug "key:"+key+", elm.item_id:"+elm.item_id+", elm.title:"+elm.title
      rows = self.db.execute 'SELECT * FROM lists where item_id = ?', elm.item_id
      #Ti.API.debug "Found: "+rows.getRowCount()
      if rows.getRowCount() is 0
        res = self.db.execute 'INSERT INTO lists (item_id, title, url, time_updated, time_added, state) VALUES (?, ?, ?, ?, ?, ?)', elm.item_id, elm.title, elm.url, elm.time_updated, elm.time_added, elm.state
        idx += 1
        #Ti.API.debug "Add to DB"+elm.title
    self.close()
    #Ti.API.debug "idx:"+idx
    return

  self.getRowCount = ()->
    self.open()
    rows = self.db.execute 'SELECT * FROM lists'
    #Ti.API.debug "getRowCount rowsCount:"+rows.getRowCount()
    self.close()
    return

  self.selectList = (item_id)->
    self.open()
    Ti.API.debug "selected :"+self.db.execute('SELECT (title) FROM lists where item_id = ?', item_id)
    self.close()
    return

  self.getSavedLists = ()->
    Ti.API.debug "getSavedLists start"
    self.open()
    #rows = self.db.execute('SELECT * FROM lists')
    rows = self.db.execute('SELECT * FROM lists order by time_updated desc')
    Ti.API.debug "count:"+rows.getRowCount()
    res = []
    if rows.getRowCount() > 0 
      while rows.isValidRow()
        #Ti.API.debug "rows.fieldByName('item_id'):"+rows.fieldByName('item_id')
        #Ti.API.debug "rows.fieldByName('title'):"+rows.fieldByName('title')
        #Ti.API.debug "rows.fieldByName('url'):"+rows.fieldByName('url')
        #Ti.API.debug "rows.fieldByName('time_updated'):"+rows.fieldByName('time_updated')
        #Ti.API.debug "rows.fieldByName('time_added'):"+rows.fieldByName('time_added')
        #Ti.API.debug "rows.fieldByName('state'):"+rows.fieldByName('state')
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
    Ti.API.debug "res.length:"+res.length
    self.close()
    return res

  self.deleteLists = ()->
    self.open()
    self.db.execute('DELETE FROM lists')
    self.close()
    Ti.API.debug "delete from lists"
    return

  self.getUrlSource = (item_id, url)->
    Ti.API.debug "self.getUrlSource start item_id:"+item_id+", url:"+url
    xhr = Ti.Network.createHTTPClient()
    xhr.open 'GET', url
    xhr.onerror = ()->
      Ti.API.debug "getUrlSource onerror, url:"+url
      return
    xhr.onload = ()->
      html = this.responseText
      Ti.API.debug "self.getUrlSource html="+html
      self.open()
      rows1 = self.db.execute('SELECT * FROM htmls where item_id = ?', item_id)
      Ti.API.debug "self.getUrlSource select from htmls Count:"+rows1.getRowCount()
      if rows1.getRowCount() is 0
        res = self.db.execute('INSERT INTO htmls (item_id, html) VALUES (?, ?)', item_id, html)
        Ti.API.debug "getUrlSource insert html, item_id:"+item_id
      rows1.close()
      self.close()
      return
    xhr.send()
    return

  self.addHtmls = ()->
    self.open()
    rows = self.db.execute 'SELECT * FROM lists'
    Ti.API.debug "self.addHtmls select form lists Count:"+rows.getRowCount()
    if rows.getRowCount() > 0 
      while rows.isValidRow()
        item_id = rows.fieldByName('item_id')
        url     = rows.fieldByName('url')
        self.getUrlSource item_id, url
        rows.next()
    rows.close()
    self.close()

  self.getSavedHtml = (item_id)->
    if item_id is null
      return
    Ti.API.debug "getSavedHtmls start"
    self.open()
    rows = self.db.execute 'SELECT * FROM htmls where item_id = ?', item_id
    Ti.API.debug "getSaveHtmls select item_id="+item_id+", count="+rows.getRowCount()
    if rows.getRowCount() is 1 
      while rows.isValidRow()
        res = rows.fieldByName('html')
        rows.next()
    rows.close()
    self.close()
    return res

  self.initialize = ()->
    self.open()
    self.db.execute 'DROP TABLE IF EXISTS lists'
    Ti.API.debug "drop table lists"
    self.db.execute 'DROP TABLE IF EXISTS htmls'
    Ti.API.debug "drop table htmls"
    self.db.execute 'CREATE TABLE IF NOT EXISTS lists (item_id TEXT, title TEXT, url TEXT, time_updated TEXT, time_added TEXT, state TEXT)'
    self.db.execute 'CREATE TABLE IF NOT EXISTS htmls (item_id TEXT, html BLOB)'
    self.close()

  self.initialize()
  return self

  #for key,elm of timeline.list
  #  idx += 1
  #  #Ti.API.debug "key:"+key+",elm.title="+elm.title
  #  row = Ti.UI.createTableViewRow()
  #  label = Ti.UI.createLabel()
  #  Ti.API.debug "elm.title="+elm.title
  #  label.text = elm.title
  #  row.add label
  #  currentdata.push row

