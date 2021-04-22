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
int n;

void setup() {
  size(800, 800, FX2D);
  
  //==== Bubbles ====
  n = 100;
  
  bubbles = new Bubble[n];
  
  int i = 0;
  while (i < n) {
    bubbles[i] = new Bubble();
    i++;
  }
  
  //==== Gif Stuff ====
  numberOfFrames = 90;
  gif = new PImage[numberOfFrames];
  
  i = 0;
  while ( i < numberOfFrames) {
    gif[i] = loadImage("frame_" + i + "_delay-0.03s.gif");
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
  println(frameRate);
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
