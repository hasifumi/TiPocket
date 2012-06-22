exports.settingView = ()->
  self = Ti.UI.createView()

  btnArea = Ti.UI.createView()
  btnArea.height = 50
  btnArea.backgroundColor = 'green'
  btnArea.top = 0

  self.add btnArea

  closeBtn = Ti.UI.createButton()
  closeBtn.title = "close"
  closeBtn.top = 10
  closeBtn.height = 20
  closeBtn.width = 50
  closeBtn.left = 10
  closeBtn.addEventListener 'click', ()->
    self.zIndex = 10
    self.hide()
    return

  btnArea.add closeBtn
  
  settingView1 = Ti.UI.createView()
  settingView1.top = 50
  settingView1.backgroundColor = 'gray'

  self.add settingView1

  lblUser = Ti.UI.createLabel()
  lblUser.text = 'Username:'
  lblUser.top = 20
  lblUser.height = 20
  lblUser.left = 20
  lblUser.width = 100
  lblUser.backgroundColor = 'black'
  lblUser.color = 'white'

  settingView1.add lblUser

  lblPasswd = Ti.UI.createLabel()
  lblPasswd.text = 'Password:'
  lblPasswd.top = 70
  lblPasswd.height = 20
  lblPasswd.left = 20
  lblPasswd.width = 100
  lblPasswd.backgroundColor = 'black'
  lblPasswd.color = 'white'

  settingView1.add lblPasswd

  tfUser = Ti.UI.createTextField()
  tfUser.top = 20
  tfUser.height = 20
  tfUser.left = 140
  tfUser.width = 150
  tfUser.backgroundColor = 'white'
  tfUser.hintText = 'Your Username'
  tfUser.autocapitalization = false
  tfUser.keybordType = Ti.UI.KEYBOARD_DEFAULT
  tfUser.returnKeyType = Ti.UI.RETURNKEY_DEFAULT
  tfUser.borderStyle = Ti.UI.INPUT_BORDERSTYLE_ROUNDED
  tfUser.addEventListener 'return', (e)->
    Ti.API.info "tfUser received, val="+e.value
    Ti.App.Properties.setString 'username', e.value
    tfUser.blur()

  settingView1.add tfUser

  tfPasswd = Ti.UI.createTextField()
  tfPasswd.top = 70
  tfPasswd.height = 20
  tfPasswd.left = 140
  tfPasswd.width = 150
  tfPasswd.backgroundColor = 'white'
  tfPasswd.hintText = 'Your Password'
  tfPasswd.autocapitalization = false
  tfPasswd.keybordType = Ti.UI.KEYBOARD_DEFAULT
  tfPasswd.returnKeyType = Ti.UI.RETURNKEY_DEFAULT
  tfPasswd.borderStyle = Ti.UI.INPUT_BORDERSTYLE_ROUNDED
  tfPasswd.addEventListener 'return', (e)->
    Ti.API.info "tfPasswd received, val="+e.value
    Ti.App.Properties.setString 'password', e.value
    tfPasswd.blur()

  settingView1.add tfPasswd

  return self


