/* Libraries
------------------------------------------------------------ */
import processing.video.*;

/* Global variables
------------------------------------------------------------ */

// Video 
Capture myCapture;

// Buttons
ImageButton btnDraw, btnSave, btnTrash;

// Colors
color cCurrent, cBlack, cWhite, cBlonde, cBrown, cRed;

// Capture dimensions
int captureW = 640;
int captureH = 480;

// UI dimensions
int uiW = captureW;
int uiH = 44;

// Utilities
boolean newbeard;

/* Setup
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
  
  btnDraw = new ImageButton(8, 488, btnDrawSrc.width, btnDrawSrc.height, btnDrawSrc, btnDrawOverSrc);
  btnSave = new ImageButton(38, 488, btnSaveSrc.width, btnSaveSrc.height, btnSaveSrc, btnSaveOverSrc);  
  btnTrash = new ImageButton(68, 488, btnTrashSrc.width, btnTrashSrc.height, btnTrashSrc, btnTrashOverSrc);
     
  cBlack = color(0);
//  TODO: Add colors to UI.
//  cWhite = color(255);
//  cBlonde = color(196, 189, 168);
//  cBrown = color(114, 72, 20);
//  cRed = color(123, 38, 24); 
  cCurrent = cBlack;

  newbeard = true;
}

/* Prep video
------------------------------------------------------------ */

void captureEvent(Capture myCapture) {
  myCapture.read();
}

/* Keyboard shortcuts
------------------------------------------------------------ */

void keyPressed() {
  // Draw Key
  if (key == 'd') { 
    newDrawing();
  }
  // Save Key
  if (key == 's') {    
    saveDrawing();
  }
  // Trash Key
  if (key == 't') {
    trashDrawing();
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
  
  if (newbeard == true) {
    image(myCapture, 0, 0); 
  }
  
  if (mousePressed == true) {
    
    if (mouseX>=captureW/2) {
      xVector = random(hLength);
    } else {
      xVector = -random(hLength); 
    }
    
    if (mouseY>=captureH/2) {
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

// Base button class
class Button
{
  int x, y;
  int w, h;
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

// Image button class
class ImageButton extends Button 
{
  PImage base;
  PImage roll;
  PImage currentimage;

  ImageButton(int ix, int iy, int iw, int ih, PImage ibase, PImage iroll)
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
  fill(72, 63, 51);
  rect(0, captureH, uiW, uiH);
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
