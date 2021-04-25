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
  background(DGrey);
  
  //Lines
  game_start_line(-5, 650, 850, 300);
  game_start_line(-5, 700, 850, 350);
  
  game_start_line(200, -5, 850, 650);
  game_start_line(150, -5, 800, 650);
  
  game_start_button(width/2, height/2, 55);  
}

void game_start_button(float x, float y, float ts) {
  pushMatrix();
  translate(x, y);
  
  fill(White);
  textFont(menuFont);
  textSize(startSize);
  
  text("<Click anywhere to start>", 0, 0);
  
  //Change size 
  startSize = startSize - 0.0625 * startSizeGrow;
  
  if (startSize == ts + 5 || startSize == ts) {
    startSizeGrow = -startSizeGrow;
  }
  
  popMatrix();
}

void game_start_click() {
  if (game_mode == _start && mode == _game) {
    game_mode = _playing;
    
    ballX = width/2;
    ballY = 3*height/4;
    ballVX = 0;
    ballVY = 5;
    
    score = 0;
    
    timer = second() + minute()*60;
    
    timeScoreStart = second() + minute()*60;

    timeScoreEnd = timeScoreTotal = timePausedStart = timePausedEnd = timePausedTotal = timeCountDown = timeScoreMinutes = timeScoreSeconds = 0;
    
    countdown = true;
    _pausedvar = true;
    
    lives = 3;
    
    paddleX = width/2;
    
    int i = 0;
    while (i < brickN) {
      alive[i] = true;
      i++;
    }
    
    button.rewind();
    button.play();
  }
}

void game_start_line(float x1, float y1, float x2, float y2) {
  stroke(Grey);
  strokeWeight(5);
  
  line(x1, y1, x2, y2);
}

//============================================
//================ Game Play =================

void game_playing() {
  background(DGrey);
  
  game_playing_paddle(paddleX, height, 150, DDGrey, Grey);
  
  game_playing_ball(ballX, ballY, 25, DDGrey, Grey);
  
  game_playing_lives(width - 120, 30);
  
  game_playing_end();
  
  game_playing_bricks();
  
  game_playing_timer(180, 30);
  
  if (countdown == true) {
    game_playing_countdowntimer(width/2, height/2, timer);
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
  if (leftkey == true && paddleX > d/2 && game_mode != _paused && countdown == false) paddleX = paddleX - 7;
  if (rightkey == true && paddleX < width - d/2 && game_mode != _paused && countdown == false) paddleX = paddleX + 7;
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
    bounce.rewind();
    bounce.play();
  } else if (ballX > width - d/2) {
    ballX = width - d/2;
    ballVX = -ballVX;
    bounce.rewind();
    bounce.play();
  }
  
  if (ballY < d/2) {
    ballY = d/2;
    ballVY = -ballVY;
    bounce.rewind();
    bounce.play();
  }
  
  if (dist(ballX, ballY, paddleX, height) < d/2 + 75) {
    ballVX = (ballX - paddleX)/10;
    ballVY = (ballY - height)/10;
    bounce.rewind();
    bounce.play();
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
    
    sscore.play();
    sscore.rewind();
  }
}

//Timer when ball respawns
//Code from my pong project
void game_playing_countdowntimer(float x, float y, int time) {
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
    timeCountDown++;
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

//Current time
void game_playing_timer(float x, float y) {
  pushMatrix();
  translate(x, y);
  
  fill(Black, 80);
  textFont(menuFont);
  textSize(55);
  
  if (game_mode == _playing && countdown == false) {
    timeScoreEnd = second() + minute()*60;
    timeScoreTotal = timeScoreEnd - timeScoreStart;
  }
  
  timeScoreSeconds = timeScoreTotal - timePausedTotal - (timeCountDown * 3) - timeScoreSecToMin*60;
  timeScoreMinutes = 0;
      
  while (timeScoreSeconds >=60) {
    timeScoreMinutes++;
    timeScoreSeconds = timeScoreSeconds - 60;
  }
    
  text("Time: " + timeScoreMinutes + "m "+ timeScoreSeconds + "s", 0, 0);
  
  popMatrix();
}

//End game
void game_playing_end() {
  if (lives < 0 || score == brickN) {
    game_mode = _end;
    score = 0;
    
    gamesplayed++;
    
    timeplayed = timeplayed + timeScoreSeconds;
    
    if ((timeScoreSeconds < timeHighscore|| timeHighscore == 0) && lives >= 0) {
      timeHighscore = timeScoreSeconds;
    }
    
    int[] stuffint = new int[4];
    stuffint[0] = difficulty;
    stuffint[1] = gamesplayed;
    stuffint[2] = timeplayed;
    stuffint[3] = timeHighscore;
    
    String[] stuffstring = str(stuffint);
    
    saveStrings("stuff.txt", stuffstring);
    
    
    endeffect.rewind();
    endeffect.play();
  }
}

//Bricks
void game_playing_bricks() {
  fill(White);
  
  int i = 0;
  while (i < brickN) {
    if (alive[i] == true) {
      game_playing_bricks_show(i);
    }
    i++;
  }
}

void game_playing_bricks_show(int i) {
  colorMode(HSB);
  
  fill(brickH[i], 180, 180);
  
  noStroke();
  circle(brickX[i], brickY[i], brickD);
  
  colorMode(RGB);
  
  if (dist(ballX, ballY, brickX[i], brickY[i]) < 12.5 + brickD/2) {
    ballVX = ((ballX - brickX[i])/(9/(difficulty + 1)));
    ballVY = ((ballY - brickY[i])/(9/(difficulty + 1)));
    alive[i] = false;
    score++;
    bounce.rewind();
    bounce.play();
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
  
  game_paused_button(40, 40);
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
  background(DGrey);
  
  game_end_text_result(width/2, height/4);
  
  game_end_text_time(width/2, 2*height/3);
}

//Result text
void game_end_text_result(float x, float y) {
  pushMatrix();
  translate(x, y);
  
  textFont(titleFont);
  textSize(130);
  
  if (lives >= 0) {
    fill(Green);
    text("You Won!", 0, 0);
  } else {
    fill(Red);
    text("You Lost", 0, 0);
  }
  
  popMatrix();
}

//Amount of time taken
void game_end_text_time(float x, float y) {
  pushMatrix();
  translate(x, y);
  
  textFont(menuFont);
  textSize(60);
  fill(White);
  
  timeScoreSeconds = timeScoreTotal - timePausedTotal - (timeCountDown * 3) - timeScoreSecToMin*60;
  timeScoreMinutes = 0;
      
  while (timeScoreSeconds >=60) {
    timeScoreMinutes++;
    timeScoreSeconds = timeScoreSeconds - 60;
  }
  
  text("Time: " + timeScoreMinutes + "m "+ timeScoreSeconds + "s", 0, 0);
  
  popMatrix();
}

//Play Again
