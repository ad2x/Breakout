class Bubble {
  float x, y, d, vx, vy;
  float h;
  Bubble() {
    d = random(10, 50);
    
    Circle_Button a = cbuttons[0];
    Circle_Button b = cbuttons[1];
    Circle_Button c = cbuttons[2];
    
    while(dist(x, y, a.x, a.y) < (d/2 + a.d/2 + 10) || dist(x, y, b.x, b.y) < (d/2 + b.d/2 + 10) || dist(x, y, c.x, c.y) < (d/2 + c.d/2 + 10) || (x == 0 && y == 0)) {
      x = random(width);
      y = random(height);
    }
    
    h = random(0, 255);
    vx = random(-4, 4);
    vy = random(-4, 4);
    PVector v = new PVector(Math.round(vx), Math.round(vy));
    v.setMag(5);
    vx = v.x;
    vy = v.y;
  }
  void show() {
    fill(h, 180, 180);
    noStroke();
    circle(x, y, d);
  }
  void act() {
    x = x + vx;
    y = y + vy;
    
    if (y < d/2) {
      y = d/2;
      vy = -vy;
    } else if (y > height - d/2) {
      y = height - d/2;
      vy = -vy;
    } else if (x < d/2) {
      x = d/2;
      vx = -vx;
    } else if (x > height - d/2) {
      x = height - d/2;
      vx = -vx;
    }
    int i = 0;
    while (i < n_b) {
      Bubble b = bubbles[i];
      if (dist(x, y, b.x, b.y) < d/2 + b.d/2 && dist(x, y, b.x, b.y) != 0) {
        vx = (x - b.x)/(d/3);
        vy = (y - b.y)/(d/3);
      }
      i++;
    }
    i = 0;
    while (i < 3) {
      Circle_Button b = cbuttons[i];
      if (dist(x, y, b.x, b.y) < d/2 + b.d/2) {
        vx = -vx;
        vy = -vy;
      }
    i++;
    }
  }
}
