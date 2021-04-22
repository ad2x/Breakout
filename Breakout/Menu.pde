void menu() {
  background(DDGrey);
  
  //Bubbles 
  int i = 0;
  colorMode(HSB);
  while (i < n) {
    bubbles[i].show();
    bubbles[i].act();
    i++;
  }
  colorMode(RGB);
  
  //Circle Buttons
  menu_button(200, 200, 200);
}

//==== Circle Buttons ====
void menu_button(float x, float y, float d) {
  pushMatrix();
  translate(x, y);
  
  float h = random(0, 255);
  fill(h, 220, 220);
  stroke(h, 160, 160);
  strokeWeight(10);
  
  if (dist(mouseX, mouseY, 0, 0) < d/2) {
    stroke(h, 145, 145);
  }
  
  circle(0, 0, d);
  
  popMatrix();
}
