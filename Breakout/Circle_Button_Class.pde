class Circle_Button {
  float x, y, d;
  color s, hs, ps, f;
  int tmode;
  String text;
  
  Circle_Button(float _x, float _y, float _d, color _s, color _hs, color _ps, color _f, int _tmode, String _text) {
    x = _x;
    y = _y;
    d = _d;
    s = _s;
    hs = _hs;
    ps = _ps;
    f = _f;
    tmode = _tmode;
    text = _text;
  }
  
  void show() {
    pushMatrix();
    translate(x, y);
    
    fill(f);
    stroke(s);
    strokeWeight(15);
    
    if (dist(mouseX, mouseY, x, y) < d/2) {
      stroke(hs);
      if (mousePressed == true) {
        stroke(ps);
      }  
    }
    
    circle(0, 0, d);
    
    fill(s);
    textFont(menuFont);
    textSize(60);
    
    text(text, 0, 0);
    
    popMatrix();
  }
  
  void click() {
    if (dist(x, y, mouseX , mouseY) < d/2 && mode == _menu) {      
      pmode.append(mode);
      
      mode = tmode;      
    }    
  }
}
