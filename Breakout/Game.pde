void game() {
  //==== Mode Framework ====
  switch(game_mode) {
    case 0:
      game_start();
      break;
    case 1:
      game_playing();
      break;
    case 2:
      game_paused();
      break;
    case 3:
      game_end();
      break;
  }
}

//============================================
//=============== Game Start =================

void game_start() {
  background(White);
  
  game_start_button(width/2, 3*height/4, 25);
}

void game_start_button(float x, float y, float ts) {
  pushMatrix();
  translate(x, y);
  
  fill(Black);
  textFont(menuFont);
  textSize(startSize);
  
  text("<Click anywhere to start>", 0, 0);
  
  //Change size 
  startSize = startSize - 0.25 * startSizeGrow;
  
  if (startSize == ts + 20 || startSize == ts) {
    startSizeGrow = -startSizeGrow;
  }
  
  popMatrix();
}

void game_start_click() {
  if (game_mode == _start && mode == _game) {
    game_mode = _playing;
  }
}

//============================================
//================ Game Play =================

void game_playing() {
  background(Grey);
  
  game_playing_paddle(paddleX, height, 150, DGrey, Grey);
}

void game_playing_paddle(float x, float y, float d, color s, color f) {
  pushMatrix();
  translate(x, y);
  
  fill(f);
  stroke(s);
  strokeWeight(10);
  
  circle(0, 0, d);
  
  popMatrix();
  
  //Movement
  if (leftkey == true && paddleX > d/2) paddleX = paddleX - 5;
  if (rightkey == true && paddleX < width - d/2) paddleX = paddleX + 5;
}

void game_playing_paddle_move() {
  if (key == 'a' || key == 'A' || keyCode == LEFT) {
    leftkey = true;
  } else {
    leftkey = false;
  }
  
  if (key == 'd' || key == 'D' || keyCode == RIGHT) {
    rightkey = true;
  } else {
    rightkey = false;
  }
}

//============================================
//============== Game Paused =================

void game_paused() {
  background(DGrey);
}

//============================================
//================= Game End =================

void game_end() {
  
}
