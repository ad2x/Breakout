void keyPressed() {
  //Title screen prompt
  anykey(_title, _menu);
  
  menu_esc();
}

//==== Menu Esc ====
void menu_esc () {
  if (keyCode == ESC && mode != _title && game_mode != _playing) {
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
  }
}
