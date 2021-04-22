class Bubble {
  float x, y, d, vx, vy;
  float h;
  Bubble() {
    x = random(width);
    y = random(height);
    d = random(10, 50);
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
    while (i < n) {
      Bubble b = bubbles[i];
      if (dist(x, y, b.x, b.y) < d/2 + b.d/2 && dist(x, y, b.x, b.y) != 0) {
        vx = (x - b.x)/(d/3);
        vy = (y - b.y)/(d/3);
      }
      i++;
    }
  }
}
