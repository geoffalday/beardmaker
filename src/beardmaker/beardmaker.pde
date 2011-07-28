/* Load processing's video stuff
------------------------------------------------------------ */

import processing.video.*;
Capture myCapture;

/* Global variables
------------------------------------------------------------ */

// Buttons
ImageButtons btnDraw, btnSave, btnTrash;

// Colors
color cCurrent, cBlack, cWhite, cBlonde, cBrown, cRed;

// Size of the video capture
int captureW = 640;
int captureH = 480;

// UI dimensions, positions
int uiH = 44;

// Utilities
boolean newbeard;

/* Set 'er up
------------------------------------------------------------ */

void setup() {
  size(captureW, captureH+uiH);
  background(0, 0, 0);
  
  myCapture = new Capture(this, captureW, captureH, 30);
  myCapture.crop(0, 0, captureW, captureH); // So grainy pixels don't bleed. 
  
  PImage btnDrawSrc = loadImage("btn-draw.png");
  PImage btnDrawOverSrc = loadImage("btn-draw-over.png");
  PImage btnSaveSrc = loadImage("btn-save.png");
  PImage btnSaveOverSrc = loadImage("btn-save-over.png");
  PImage btnTrashSrc = loadImage("btn-trash.png");
  PImage btnTrashOverSrc = loadImage("btn-trash-over.png");
  
  btnDraw = new ImageButtons(8, 488, btnDrawSrc.width, btnDrawSrc.height, btnDrawSrc, btnDrawOverSrc);
  btnSave = new ImageButtons(38, 488, btnSaveSrc.width, btnSaveSrc.height, btnSaveSrc, btnSaveOverSrc);  
  btnTrash = new ImageButtons(68, 488, btnTrashSrc.width, btnTrashSrc.height, btnTrashSrc, btnTrashOverSrc);
     
  cBlack = color(0);
  cWhite = color(255);
  cBlonde = color(196, 189, 168);
  cBrown = color(114, 72, 20);
  cRed = color(123, 38, 24); 
  cCurrent = cBlack;
  
  newbeard = true;
}

/* Fire up the video feed
------------------------------------------------------------ */

void captureEvent(Capture myCapture) {
  myCapture.read();
}

/* Keyboard UI
------------------------------------------------------------ */

void keyPressed() {
  
  // Draw Key
  if (key == 'n') { 
    newDrawing();
  }
  
  // Save Key
  if (key == 's') {    
    saveDrawing();
  }
  
  // Trash Key
  if (key == 't') {
    newbeard = true;
  }
  
}

/* Draw
------------------------------------------------------------ */

void draw() {
 
  // Whiskers
  float baseStart = 3;
  float baseLength = 10;  
  float hStart = random(-baseStart, baseStart);
  float hLength = random(baseLength); 
  float xVector;
  float yVector;
  
  // Clear out pose
  if (newbeard == true) {
    image(myCapture, 0, 0); 
  }
  
  // Draw whiskers
  if (mousePressed == true) {
    
    if (mouseX>=width/2) {
      xVector = random(hLength);
    } else {
      xVector = -random(hLength); 
    }
    
    if (mouseY>=240/2) {
      yVector = random(hLength);
    } else {
      yVector = -random(hLength);
    }
      
    stroke(cCurrent, 75);
    strokeWeight(1);
    smooth();
    line(mouseX+hStart, mouseY+hStart, mouseX+xVector, mouseY+yVector);   
    
  }
  
  // UI
  renderUIBackground();
  
  if (btnDraw.pressed) {
    newDrawing();
  }
  
  if (btnSave.pressed) {
    saveDrawing();
  }
  
  if (btnTrash.pressed) {
    trashDrawing();
  }

  // Show Draw Button
  btnDraw.update();
  btnDraw.display(); 
    
  // Show Save Button
  btnSave.update();
  btnSave.display();
    
  // Show Delete Button
  btnTrash.update();
  btnTrash.display();
 
}

/* Classes
------------------------------------------------------------ */

class Button
{
  int x, y;
  int w, h;
  int size;
  color basecolor, highlightcolor;
  color currentcolor;
  boolean over = false;
  boolean pressed = false;   
  
  void pressed() {
    if(over && mousePressed) {
      pressed = true;
    } else {
      pressed = false;
    }    
  }
  
  boolean overRect(int x, int y, int width, int height) {
    if (mouseX >= x && mouseX <= x+width && mouseY >= y && mouseY <= y+height) {
      return true;
    } else {
      return false;
    }
  }
}

class ImageButtons extends Button 
{
  PImage base;
  PImage roll;
  PImage currentimage;

  ImageButtons(int ix, int iy, int iw, int ih, PImage ibase, PImage iroll)
  {
    x = ix;
    y = iy;
    w = iw;
    h = ih;
    base = ibase;
    roll = iroll;
    currentimage = base;
  }
  
  void update() 
  {
    over();
    pressed();
    if (over) {
      currentimage = roll;
    } else {
      currentimage = base;
    }
  }
  
  void over() 
  {
    if( overRect(x, y, w, h) ) {
      over = true;
    } else {
      over = false;
    }
  }
  
  void display() 
  {
    image(currentimage, x, y);
  }
}

/* Functions
------------------------------------------------------------ */

// Render the UI background
void renderUIBackground() {
  noStroke();
  fill(72, 63, 51); // BG
  rect(0, 480, 650, 44);
}

// Create a new drawing
void newDrawing() {
  image(myCapture, 0, 0);
  newbeard = false;
}

// Trash the drawing and start over
void trashDrawing() {
  newbeard = true;
} 

// Save a drawing
void saveDrawing() {
  PImage sImage;
  sImage = get(0, 0, captureW, captureH);
  sImage.save("beard-" + timestamp() + ".png");  
}

// Create a timestamp
String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS%1$tL", now);
}
