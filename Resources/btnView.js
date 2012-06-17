exports.btnView = function() {
  var btnHide, btnShow, self;
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
    Ti.API.info("btnShow clicked");
    return tblView.show();
  });
  self.add(btnShow);
  btnHide = Ti.UI.createButton();
  btnHide.title = 'hide';
  btnHide.width = 50;
  btnHide.height = 20;
  btnHide.left = 70;
  btnHide.addEventListener('click', function() {
    Ti.API.info("btnHide clicked");
    return tblView.hide();
  });
  self.add(btnHide);
  return self;
};