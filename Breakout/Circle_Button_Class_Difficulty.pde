class difficulty_button {
  float x, y, d;
  color s, hs, ps, f;
  int di;
  String text;
  int ts;
  
  difficulty_button(float _x, float _y, float _d, color _s, color _hs, color _ps, color _f, int di2, String _text, int _ts) {
    x = _x;
    y = _y;
    d = _d;
    s = _s;
    hs = _hs;
    ps = _ps;
    f = _f;
    di = di2; //Why isn't _di a valid name???
    text = _text;
    ts = _ts;
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
    
    if (difficulty == di) {
      stroke(ps);
    }
    
    circle(0, 0, d);
    
    fill(s);
    textFont(menuFont);
    textSize(ts);
    
    text(text, 0, 0);
    
    popMatrix();
  }
  
  void click() {
    if (dist(x, y, mouseX , mouseY) < d/2 && mode == _settings) {      
      difficulty = di;
    }    
  }
}
