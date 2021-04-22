void title() {
  title_gif();
  
  title_text(width/2, height/4, 120);
}

//==== Gif ====
void title_gif() {
  image(gif[f], 0, 0, width, height);
  f++;
  
  if (f == numberOfFrames) {
    f = 0;
  }
}

//==== Title ====
void title_text(float x, float y, float s) {
  pushMatrix();
  translate(x, y);
  
  fill(White);
  textFont(titleFont);
  textSize(s);
  
  text("Breaker", 0, 0);
  
  textFont(menuFont);
  textSize(30);
  
  text("<Press any key to continue>", 0, height/3);
  
  popMatrix();
}

//==== Press Any Key ====
void anykey(int c_mode, int t_mode) {
  if (mode == c_mode) {
    pmode.append(mode);
    
    mode = t_mode;
  }
}
