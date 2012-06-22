exports.btnView = function() {
  var btnHide, btnReload, btnSet, btnShow, btnWeb, self;
  self = Ti.UI.createView();
  self.height = 50;
  self.top = 0;
  self.backgroundColor = 'blue';
  btnShow = Ti.UI.createButton();
  btnShow.title = 'show';
  btnShow.width = 50;
  btnShow.height = 20;
  btnShow.left = 10;
  btnShow.addEventListener('click', function() {
    Ti.API.debug("btnShow clicked");
    return tblView.show();
  });
  self.add(btnShow);
  btnHide = Ti.UI.createButton();
  btnHide.title = 'hide';
  btnHide.width = 50;
  btnHide.height = 20;
  btnHide.left = 70;
  btnHide.addEventListener('click', function() {
    Ti.API.debug("btnHide clicked");
    return tblView.hide();
  });
  self.add(btnHide);
  btnWeb = Ti.UI.createButton();
  btnWeb.title = 'Web';
  btnWeb.width = 50;
  btnWeb.height = 20;
  btnWeb.left = 130;
  btnWeb.addEventListener('click', function() {
    Ti.API.debug("btnWeb clicked");
    webView.zIndex = 30;
    webView.updateHtml('<html><body>Test!</body></html>');
    return webView.show();
  });
  self.add(btnWeb);
  btnSet = Ti.UI.createButton();
  btnSet.title = 'Set';
  btnSet.width = 50;
  btnSet.height = 20;
  btnSet.left = 190;
  btnSet.addEventListener('click', function() {
    Ti.API.debug("btnSet clicked");
    settingView.zIndex = 30;
    return settingView.show();
  });
  self.add(btnSet);
  btnReload = Ti.UI.createButton();
  btnReload.title = 'Reload';
  btnReload.width = 70;
  btnReload.height = 20;
  btnReload.left = 250;
  btnReload.addEventListener('click', function() {
    Ti.API.debug("btnReload clicked");
    tblView.setData = [];
    return loadLits();
  });
  self.add(btnReload);
  return self;
};