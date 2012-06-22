exports.webView = function() {
  var btnArea, closeBtn, self, webView1;
  self = Ti.UI.createView();
  btnArea = Ti.UI.createView();
  btnArea.height = 50;
  btnArea.backgroundColor = 'red';
  btnArea.top = 0;
  self.add(btnArea);
  closeBtn = Ti.UI.createButton();
  closeBtn.title = "close";
  closeBtn.top = 10;
  closeBtn.height = 20;
  closeBtn.width = 50;
  closeBtn.left = 10;
  closeBtn.addEventListener('click', function() {
    self.zIndex = 10;
    self.hide();
  });
  btnArea.add(closeBtn);
  webView1 = Ti.UI.createWebView();
  webView1.top = 50;
  webView1.backgroundColor = 'white';
  self.add(webView1);
  self.updateHtml = function(html_src) {
    webView1.html = html_src;
  };
  return self;
};