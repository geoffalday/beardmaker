import processing.video.*;
Capture myCapture;

<<<<<<< HEAD
PImage btnDraw;
PImage btnSave;
PImage btnTrash;
int colorsX;  
int colorsY;
int colorBlock;
int colorBlockOffsetX;
int colorBlockOffsetY;
int cCurrentX;
int cCurrentY;
color cCurrent;
color cBlack;
color cWhite;
color cBlonde;
color cBrown;
color cRed;
color[] colors;
PImage sImage;
float baseStart;
float baseLength;
float xVector;
float yVector;
float hStart;
float hLength;
float m;
=======
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
>>>>>>> refactor
boolean newbeard;

void setup() {
<<<<<<< HEAD
  size(320, 284);
  background(72, 63, 51); 
  myCapture = new Capture(this, 320, 240, 30);
  myCapture.crop(0, 0, 320, 240); // So grainy pixels don't bleed.
  btnDraw = loadImage("btn-draw.png");
  btnSave = loadImage("btn-save.png");
  btnTrash = loadImage("btn-trash.png");
  colorsX = 119;  
  colorsY = 242;
  colorBlock = 14;
  colorBlockOffsetX = 6;
  colorBlockOffsetY = 8;    
=======
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
     
>>>>>>> refactor
  cBlack = color(0);
  cWhite = color(255);
  cBlonde = color(196, 189, 168);
  cBrown = color(114, 72, 20);
  cRed = color(123, 38, 24); 
  cCurrent = cBlack;
<<<<<<< HEAD
  colors = new color[5];
  colors[0] = cBlack;
  colors[1] = cWhite;
  colors[2] = cBlonde;
  colors[3] = cBrown;
  colors[4] = cRed;  
  baseStart = 3;
  baseLength = 10;  
=======
  
>>>>>>> refactor
  newbeard = true;
}

void captureEvent(Capture myCapture) {
  myCapture.read();
}

void keyPressed() {
  // Draw Key
<<<<<<< HEAD
  if (key == 'b') { 
    image(myCapture, 0, 0);
    newbeard = false;
    mode = "draw";
=======
  if (key == 'n') { 
    newDrawing();
>>>>>>> refactor
  }
  // Save Key
  if (key == 's') {    
<<<<<<< HEAD
    sImage = get(0, 0, 320, 240);
    sImage.save("beard-" + m + ".png");
=======
    saveDrawing();
>>>>>>> refactor
  }
  // Trash Key
  if (key == 't') {
    newbeard = true;
  }
}

<<<<<<< HEAD
void mousePressed() {
  
  if (mode == "pose") {
    // Draw Button
    if (mouseX >= 148 && mouseX <= 173 && mouseY >= 249 && mouseY <= 274) {
      image(myCapture, 0, 0);
      newbeard = false;    
      mode = "draw";
    }
  } 
  
  if (mode == "draw") {
    // Save Button
    if (mouseX >= 82 && mouseX <= 107 && mouseY >= 249 && mouseY <= 274) {
      sImage = get(0, 0, 320, 240);
      sImage.save("beard-" + m + ".png");     
    }  
    // Trash Button
    if (mouseX >= 213 && mouseX <= 238 && mouseY >= 249 && mouseY <= 274) {
      newbeard = true;
      mode = "pose";
    }
    // Colors    
    // Black
    if (mouseX >= colorsX+colorBlockOffsetX && mouseX <= colorsX+colorBlockOffsetX+colorBlock && mouseY >= colorsY+colorBlockOffsetY && mouseY <= colorsY+colorBlockOffsetY+colorBlock) {
      cCurrent = cBlack; 
      cCurrentX = 127;
    }
    // White
    if (mouseX >= colorsX+colorBlockOffsetX+colorBlock && mouseX <= colorsX+colorBlockOffsetX+(colorBlock*2) && mouseY >= colorsY+colorBlockOffsetY && mouseY <= colorsY+colorBlockOffsetY+colorBlock) {
      cCurrent = cWhite; 
      cCurrentX = 141;
    }
    // Blonde
    if (mouseX >= colorsX+colorBlockOffsetX+(colorBlock*2) && mouseX <= colorsX+colorBlockOffsetX+(colorBlock*3) && mouseY >= colorsY+colorBlockOffsetY && mouseY <= colorsY+colorBlockOffsetY+colorBlock) {
      cCurrent = cBlonde; 
      cCurrentX = 155;
    }  
    // Brown
    if (mouseX >= colorsX+colorBlockOffsetX+(colorBlock*3) && mouseX <= colorsX+colorBlockOffsetX+(colorBlock*4) && mouseY >= colorsY+colorBlockOffsetY && mouseY <= colorsY+colorBlockOffsetY+colorBlock) {
      cCurrent = cBrown;
      cCurrentX = 169; 
    }    
    // Red
    if (mouseX >= colorsX+colorBlockOffsetX+(colorBlock*4) && mouseX <= colorsX+colorBlockOffsetX+(colorBlock*5) && mouseY >= colorsY+colorBlockOffsetY && mouseY <= colorsY+colorBlockOffsetY+colorBlock) {
      cCurrent = cRed;
      cCurrentX = 183; 
    }    
  } 
}

void draw() {
  m = millis();
  
  hStart = random(-baseStart, baseStart);
  hLength = random(baseLength);
=======
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
>>>>>>> refactor
  
  if (newbeard == true) {
    image(myCapture, 0, 0); 
  }
  
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
<<<<<<< HEAD
  noSmooth();
  strokeWeight(1);
  stroke(44, 38, 29);
  line(0, 240, 320, 240);
  stroke(59, 51, 41);
  line(0, 241, 320, 241);
  stroke(67, 58, 47);
  line(0, 242, 320, 242);
  noStroke();
  fill(72, 63, 51); // BG
  rect(0, 243, 320, 39);
  stroke(67, 58, 47);
  line(0, 282, 320, 282);
  stroke(59, 51, 41);
  line(0, 283, 320, 283);

  
  if (mode == "pose") {
    
    // Draw Button
    image(btnDraw, 148, 249); 
    
=======
  renderUIBackground();
  
  if (btnDraw.pressed) {
    newDrawing();
  }
  
  if (btnSave.pressed) {
    saveDrawing();
>>>>>>> refactor
  }
  
  if (btnTrash.pressed) {
    trashDrawing();
  }

  // Show Draw Button
  btnDraw.update();
  btnDraw.display(); 
    
<<<<<<< HEAD
    /// Save Button
    image(btnSave, 82, 249);
    
    // Delete Button
    image(btnTrash, 213, 249);
=======
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
>>>>>>> refactor
  
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
<<<<<<< HEAD
=======

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
>>>>>>> refactor
