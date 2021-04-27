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

//Minim
Minim minim;
AudioPlayer bounce;
AudioPlayer button;
AudioPlayer won;
AudioPlayer lost;
AudioPlayer theme;
AudioPlayer readyeffect;
AudioPlayer sscore;

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
int lives;

//Paddle
float paddleX;

boolean leftkey;
boolean rightkey;

//Ball
float ballX;
float ballY;

float ballVX;
float ballVY;

//Bricks
int[] brickX;
int[] brickY;
boolean[] alive;
float[] brickH;
int brickN;
int brickD;
int tempx = 100;
int tempy = 100;

//Score
int score;

//Timing 
int timeScoreStart;
int timeScoreEnd;
int timeScoreTotal;
int timeScoreMinutes;
int timeScoreSeconds;
int timeScoreSecToMin;
int timePausedStart;
int timePausedEnd;
int timePausedTotal;
int timeCountDown;

//Difficulty
int difficulty;
final int easy = 0;
final int medium = 1;
final int hard = 2;

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

color DGreen = #458B00;
color Green = #0AC92B;
color LGReen = #7FFF00;

color DRed = #B22222;
color Red = #EE2C2C;
color LRed = #FF0000;

//==== Fonts ====
PFont titleFont;
PFont menuFont;

//==== Bubble Variables ====
Bubble[] bubbles;
int n_b;

//==== Circle Button Variables ====
Circle_Button[] cbuttons;

//==== Moving Start Text ====
float startSize = 55;
float startSizeGrow = -1;

//==== Pausing + Countdown ====
boolean _pausedvar = true;

boolean countdown = true;

int timer;

//==== Difficulty ====
difficulty_button[] dbuttons;

//==== Statistics ====
int gamesplayed;
int timeplayed;
int timeHighscore;

void setup() {
  //Minim
  //Copied the sounds effects from my pong project
  minim = new Minim(this);
  bounce = minim.loadFile("bounce.mp3");
  won = minim.loadFile("end.mp3");
  button = minim.loadFile("button.mp3");
  theme = minim.loadFile("theme.mp3");
  sscore = minim.loadFile("score.mp3");
  lost = minim.loadFile("lost.mp3");
  
  int volume = -35;
  
  theme.setGain(volume);
  bounce.setGain(volume);
  won.setGain(volume);
  button.setGain(volume);
  sscore.setGain(volume);
  lost.setGain(volume);
  
  size(800, 800, FX2D);
  
  //==== Stats + Difficulty ====
  String[] stuff = loadStrings("stuff.txt");
  difficulty = Integer.parseInt(stuff[0]);
  gamesplayed = Integer.parseInt(stuff[1]);
  timeplayed = Integer.parseInt(stuff[2]);
  timeHighscore = Integer.parseInt(stuff[3]);
  
  //==== Gif Stuff ====
  numberOfFrames = 90;
  gif = new PImage[numberOfFrames];
  
  int i = 0;
  while ( i < numberOfFrames) {
    gif[i] = loadImage("frame_" + i + "_delay-0.03s.gif");
    i++;
  }
  
  //==== Circle Buttons (Menu) ====
  cbuttons = new Circle_Button[3];
  cbuttons[0] = new Circle_Button(225, 250, 200, Grey, DGrey, 40, LGrey, _game, "Play", 50);
  cbuttons[1] = new Circle_Button(600, 300, 200, Grey, DGrey, 40, LGrey, _settings, "Difficulty", 35);
  cbuttons[2] = new Circle_Button(400, 550, 200, Grey, DGrey, 40, LGrey, _stats, "Stats", 50);
  
  //==== Circle Buttons (Difficulty) ====
  dbuttons = new difficulty_button[3];
  dbuttons[0] = new difficulty_button(536, 209, 200, Grey, DGrey, 40, LGrey, easy, "Easy", 50);
  dbuttons[1] = new difficulty_button(247, 350, 200, Grey, DGrey, 40, LGrey, medium, "Medium", 45);
  dbuttons[2] = new difficulty_button(536, 552, 200, Grey, DGrey, 40, LGrey, hard, "Hard", 50);
  
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
  
  //==== Paddle + Ball ====
  paddleX = width/2;
  
  ballX = width/2;
  ballY = 3*height/4;
  ballVY = 5;
  
  //==== Bricks ====
  brickN = 28;
  
  brickX = new int[brickN];
  brickY = new int[brickN];
  alive = new boolean[brickN];
  brickH = new float[brickN];
  
  brickD = 35;
  
  i = 0;
  colorMode(HSB);
  while (i < brickN) {
    brickX[i] = tempx;
    brickY[i] = tempy;
    
    alive[i] = true;
    
    tempx = tempx + 100;
    if (tempx == width) {
      tempy = tempy + 100;
      tempx = 100;
    }
    
    if (brickY[i] == 100) {
      brickH[i] = random(270, 360);
    }
    if (brickY[i] == 200) {
      brickH[i] = random(165, 200);
    }
    if (brickY[i] == 300) {
      brickH[i] = random(90, 120);
    }
    if (brickY[i] == 400) {
      brickH[i] = random(50, 60);
    }
    
    i++;
  }
  colorMode(RGB);
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
  
  //Theme
  theme();
}

//Toggle theme
void theme() {
  if (mode == _title) {
    theme.play();
    if (theme.position()>=theme.length()) {
      theme.rewind();
    }
  } else {
    theme.pause();
  }
}
