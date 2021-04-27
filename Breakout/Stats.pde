void stats() {
  background(DGrey);
  
  //Title
  stats_text_heading(width/2, 50);
  
  //Stats
  stats_stats(50, 150);
}

void stats_text_heading(float x, float y) {
  pushMatrix();
  translate(x, y);
  
  fill(White);
  textFont(titleFont);
  textSize(100);
  
  text("Statistics", 0, 0);
  
  popMatrix();
}

void stats_stats(float x, float y) {
  pushMatrix();
  translate(x, y);
  
  fill(Grey);
  noStroke();
  
  rect(0, 0, 700, 600);
  
  fill(White);
  textFont(menuFont);
  textSize(70);
  
  textAlign(TOP, LEFT);

  text("Games played: " + gamesplayed, 20, 65);
  
  int timeplayed_ = timeplayed;
  int timeplayed_minutes = 0;
      
  while (timeplayed_ >=60) {
    timeplayed_minutes++;
    timeplayed_ = timeplayed_ - 60;
  }
    
  text("Time: " + timeplayed_minutes + "m "+ timeplayed_ + "s", 20, 195);
  
  int timeHighscore_ = timeHighscore;
  int timeHigscore_m = 0;
      
  while (timeHighscore_ >=60) {
    timeHigscore_m++;
    timeHighscore_ = timeHighscore_ - 60;
  }
  
  if (timeHighscore != 0) {
    text("Highscore: " + timeHigscore_m + "m "+ timeHighscore_ + "s", 20, 325);
  } else {
    text("Highscore: N/A", 20, 325);
  }
  
  textAlign(CENTER, CENTER);
  
  popMatrix();
}
