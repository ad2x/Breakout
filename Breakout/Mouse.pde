void mouseReleased() {
  //Game start prompt
  game_start_click();
  
  //Circle Buttons
  for(int i = 0; i < 3; i++) {
    cbuttons[i].click();
  }

  //Title screen prompt
  anykey(_title, _menu);
  
  //Pause exit button
  game_paused_button_click(30, 30);
}

void mousePressed() {
}
