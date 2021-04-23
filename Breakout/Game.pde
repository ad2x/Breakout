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
    
    timer = second() + minute()*60;
    
    lives = 3;
    
    paddleX = width/2;
  }
}

//============================================
//================ Game Play =================

void game_playing() {
  background(Grey);
  
  game_playing_paddle(paddleX, height, 150, DGrey, Grey);
  
  game_playing_ball(ballX, ballY, 25, DGrey, Grey);
  
  game_playing_lives(width - 120, 30);
  
  game_playing_end();
  
  game_playing_bricks();
  
  if (countdown == true) {
    countdowntimer(width/2, height/2, timer);
  }
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
  if (leftkey == true && paddleX > d/2 && game_mode != _paused && countdown == false) paddleX = paddleX - 5;
  if (rightkey == true && paddleX < width - d/2 && game_mode != _paused && countdown == false) paddleX = paddleX + 5;
}

void game_playing_paddle_move() {
  if (key == 'a' || key == 'A' || keyCode == LEFT) {
    if (_pausedvar == false && countdown == false) {
      leftkey = true;
    }
  } else {
    leftkey = false;
  }
  
  if (key == 'd' || key == 'D' || keyCode == RIGHT) {
    if (_pausedvar == false && countdown == false) {
      rightkey = true;
    }
  } else {
    rightkey = false;
  }
}

void game_playing_ball(float x, float y, float d, color s, color f) {
  pushMatrix();
  translate(x, y);
  
  fill(f);
  stroke(s);
  strokeWeight(5);
  
  circle(0, 0, d);
  
  popMatrix();
  
  //Movement
  if (_pausedvar == false && game_mode != _paused) {
    ballX = ballX + ballVX;
    ballY = ballY + ballVY;
  }
  
  if (ballX < d/2) {
    ballX = d/2;
    ballVX = -ballVX;
  } else if (ballX > width - d/2) {
    ballX = width - d/2;
    ballVX = -ballVX;
  }
  
  if (ballY < d/2) {
    ballY = d/2;
    ballVY = -ballVY;
  }
  
  if (dist(ballX, ballY, paddleX, height) < d/2 + 75) {
    ballVX = (ballX - paddleX)/10;
    ballVY = (ballY - height)/10;
  }
  
  if (ballY - d/2 > height) {
    timer = second() + minute()*60;
    if (lives != 0) {
      countdown = true;
      _pausedvar = true;
    }
    ballX = width/2;
    ballY = 3*height/4;
    ballVY = 5;
    ballVX = 0;
    
    lives--;
  }
}

//Timer when ball respawns
//Code from my pong project
void countdowntimer(float x, float y, int time) {
  pushMatrix();
  translate(x, y);
  
  fill(DDGrey, 90);
  textFont(titleFont);
  textSize(300);
  
  int secondsleft = time - (second() + minute() * 60) + 3;
  
  text(secondsleft, 0, 0);
  
  popMatrix();
  
  //End timer
  if (secondsleft == 0) {
    countdown = false;
    _pausedvar = false;
  }
  
  //Not really related to the timer itself but needs to only happen while the timer is called
  if (abs(width/2 - paddleX) > 8) {
    if (paddleX < width/2) {
      paddleX = paddleX + 8;
    } else if (paddleX > width/2) {
      paddleX = paddleX - 8;
    }
  }
}

//Lives Counter
void game_playing_lives(float x, float y) {
  pushMatrix();
  translate(x, y);
  
  fill(Black, 80);
  textFont(menuFont);
  textSize(55);
  
  text("Lives: " + lives, 0, 0);
  
  popMatrix();
}

//End game @ 0 lives
void game_playing_end() {
  if (lives == 0) {
    game_mode = _end;
  }
}

//Bricks
void game_playing_bricks() {
  fill(White);
  
  int i = 0;
  while (i < brickN) {
    circle(brickX[i], brickY[i], brickD);
    if (dist(ballX, ballY, brickX[i], brickY[i]) < 12.5 + brickD/2) {
      ballVX = (ballX - brickX[i])/3;
      ballVY = (ballY - brickY[i])/3;
    }
    i++;
  }
}

//============================================
//============== Game Paused =================

void game_paused() {
  //Runs game_playing in background
  game_playing();
  
  //Translucent box over top
  fill(Black, 80);
  noStroke();
  rect(0, 0, width, height);
  
  game_paused_button(30, 30);
}

void game_paused_button(float x, float y) {
  pushMatrix();
  translate(x, y);
  
  stroke(White);
  strokeWeight(5);
  
  if (mouseX > x - 15 && mouseX < x + 15 && mouseY > y - 15 && mouseY < y + 15) {
    stroke(Black);
    if (mousePressed == true) {
      stroke(DDGrey);
    }
  }
  
  line(-15, -15, 15, 15);
  line(-15, 15, 15, -15);
  
  popMatrix();
}

void game_paused_button_click(float x, float y) {
  if (mouseX > x - 15 && mouseX < x + 15 && mouseY > y - 15 && mouseY < y + 15) {
    game_mode = _start;
    mode = _menu;
    
    paddleX = width/2;
    
    ballX = width/2;
    ballY = 3*height/4;
    
    ballVX = 0;
    ballVY = 5;
    
    countdown = true;
    _pausedvar = true;
  }
}

//============================================
//================= Game End =================

void game_end() {
  background(White);
}
