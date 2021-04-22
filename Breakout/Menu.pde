void menu() {
  background(White);
}

//Background Circles
void menu_circle(float x, float y, float d, color s, color f) {
  pushMatrix();
  translate(x, y);
  
  fill(f);
  stroke(s);
  strokeWeight(d/50);
  
  circle(0, 0, d);
  
  popMatrix();
}
