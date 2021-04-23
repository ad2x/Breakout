void keyPressed() {
  //Title screen prompt
  anykey(_title, _menu);
  
  //Esc to go back to last mode
  menu_esc();
  
  //Pause and unpause
  pause_esc();
  
  //Moving Paddle
  game_playing_paddle_move();
}

void keyReleased() {
  //Moving Paddle
  if (key == 'a' || key == 'A' || keyCode == LEFT) {
    leftkey = false;
  }
  if (key == 'd' || key == 'D' || keyCode == RIGHT) {
    rightkey = false;
  }
}

//==== Menu Esc ====
void menu_esc () {
  if (keyCode == ESC && mode != _title && game_mode != _playing && game_mode != _paused) {
    key = 0;
    
    int lmode = pmode.get(pmode.size() - 1);
    pmode.remove(pmode.get(pmode.size() - 1));
    
    mode = lmode;
    
    game_mode = _start;
  }
}

//==== Pausing Esc ====
void pause_esc() {
  if (keyCode == ESC && game_mode == _playing) {
    key = 0;
    
    game_mode = _paused;
  } else if (keyCode == ESC && game_mode == _paused) {
    key = 0;
    
    game_mode = _playing;
  }
}
