import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

import java.util.Arrays;

//Alexander Double
//1-4b
//4-21-2021

//==== Mode Framework ====
int mode;

final int _title = 0;
final int _menu = 1;
final int _game = 2;
final int _settings = 3;
final int _stats = 4;

//==== Game Mode Framework ====
int game_mode;

final int _start = 0;
final int _playing = 1;
final int _paused = 2;
final int _end = 3;

//==== Game Variables ====
//General
int lives = 3;

//Paddle
float paddleX = width/2;

boolean leftkey;
boolean rightkey;

//==== Keyboard Variables ====
//-- Esc --
IntList pmode;

//==== Gif Variables ====
PImage[] gif;
int numberOfFrames;
int f;

//==== Colour Palette ====
color Black = #000000;
color DDGrey = #393939;
color DGrey = #5A5A5A;
color Grey = #818181;
color LGrey = #A7A7A7;
color LLGrey = #C6C6C6;
color White = #FFFFFF;

//==== Fonts ====
PFont titleFont;
PFont menuFont;

//==== Bubble Variables ====
Bubble[] bubbles;
int n_b;

//==== Circle Button Variables ====
Circle_Button[] cbuttons;

//==== Moving Start Text ====
float startSize = 25;
float startSizeGrow = -1;

void setup() {
  size(800, 800, FX2D);
  
  //==== Gif Stuff ====
  numberOfFrames = 90;
  gif = new PImage[numberOfFrames];
  
  int i = 0;
  while ( i < numberOfFrames) {
    gif[i] = loadImage("frame_" + i + "_delay-0.03s.gif");
    i++;
  }
  
  //==== Circle Buttons ====
  cbuttons = new Circle_Button[3];
  cbuttons[0] = new Circle_Button(225, 250, 200, Grey, DGrey, Black, LGrey, _game, "Play");
  cbuttons[1] = new Circle_Button(600, 300, 200, Grey, DGrey, Black, LGrey, _settings, "Settings");
  cbuttons[2] = new Circle_Button(400, 550, 200, Grey, DGrey, Black, LGrey, _stats, "Stats");
  
  //==== Bubbles ====
  n_b = 100;
  
  bubbles = new Bubble[n_b];
  
  i = 0;
  while (i < n_b) {
    bubbles[i] = new Bubble();
    i++;
  }
  
  //==== Fonts ====
  titleFont = createFont("titleFont.otf", 200);
  menuFont = createFont("menuFont.otf", 50);
  textAlign(CENTER, CENTER);
  
  //==== PMode ====
  pmode = new IntList();
}

void draw() {
  //==== Mode Framework ====
  switch(mode) {
    case 0:
      title();
      break;
    case 1:
      menu();
      break;
    case 2:
      game();
      break;
    case 3:
      settings_();
      break;
    case 4:
      stats();
      break;
  }
}
