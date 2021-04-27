void menu() {
  background(DDGrey);
  
  //Bubbles 
  int i = 0;
  colorMode(HSB);
  while (i < n_b) {
    bubbles[i].show();
    bubbles[i].act();
    i++;
  }
  colorMode(RGB);
  
  //Circle Buttons
  for(i = 0; i < 3; i++) {
    cbuttons[i].show();
  }
}
