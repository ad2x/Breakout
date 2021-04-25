void settings_() {
  background(DDGrey);
  
  //Difficulty buttons
  for(int i = 0; i < 3; i++) {
    dbuttons[i].show();
  }
  
  //Heading
  settings_text(width/2, 50);
}

//Heading
void settings_text(float x, float y) {
  pushMatrix();
  translate(x, y);
  
  fill(White);
  textFont(titleFont);
  textSize(100);
  
  text("Difficulty", 0, 0);
  
  popMatrix();
}
