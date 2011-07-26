/* Load processing's video stuff
------------------------------------------------------------ */

import processing.video.*;
Capture myCapture;

/* Global variables
------------------------------------------------------------ */

// Size of the vido capture
int captureW = 640;
int captureH = 480;

// UI dimensions, positions
int uiW = captureW;
int uiH = 44;
int uiX = 0;
int uiY = captureH;
int uiButtonOffsetY = 9;

// Colors
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

// Utilities
boolean newbeard;
String mode;

/* Set 'er up
------------------------------------------------------------ */

void setup() {
  size(captureW, captureH+uiH);
  background(0, 0, 0);
  
  myCapture = new Capture(this, captureW, captureH, 30);
  myCapture.crop(0, 0, captureW, captureH); // So grainy pixels don't bleed. 
  
  colorsX = 119;  
  colorsY = captureH+2;
  colorBlock = 14;
  colorBlockOffsetX = 6;
  colorBlockOffsetY = 8;    
  cBlack = color(0);
  cWhite = color(255);
  cBlonde = color(196, 189, 168);
  cBrown = color(114, 72, 20);
  cRed = color(123, 38, 24);
  cCurrentX = 127;
  cCurrentY = 275;
  cCurrent = cBlack;
  colors = new color[5];
  colors[0] = cBlack;
  colors[1] = cWhite;
  colors[2] = cBlonde;
  colors[3] = cBrown;
  colors[4] = cRed;  
  
  newbeard = true;
  mode = "pose";
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
  if (key == 'd') { 
    image(myCapture, 0, 0);
    newbeard = false;
    mode = "draw";
  }
  
  // Save Key
  if (key == 's') {    
    saveImage();
  }
  
  // Trash Key
  if (key == 'n') {
    newbeard = true;
    mode = "pose";
  }
  
}

/* Mouse UI
------------------------------------------------------------ */

void mousePressed() {
  
  int uiButtonsYMin = uiY+uiButtonOffsetY;
  int uiButtonsYMax = uiY+uiButtonOffsetY+25; // Buttons are 25x25.
  
  if (mode == "pose") {
    // Draw Button
    if (mouseX >= 148 && mouseX <= 173 && mouseY >= uiButtonsYMin && mouseY <= uiButtonsYMax) {
      image(myCapture, 0, 0);
      newbeard = false;    
      mode = "draw";
    }
  } 
  
  if (mode == "draw") {
    // Save Button
    if (mouseX >= 82 && mouseX <= 107 && mouseY >= uiButtonsYMin && mouseY <= uiButtonsYMax) {
      saveImage();  
    }  
    // Trash Button
    if (mouseX >= 213 && mouseX <= 238 && mouseY >= uiButtonsYMin && mouseY <= uiButtonsYMax) {
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

  if (mode == "pose") {
    
    // Show Draw Button
    renderUIButton("btn-draw.png", 148, 489); //offset +9 vertical
    
  }
  
  if (mode == "draw") {
    
    // Show Save Button
    renderUIButton("btn-save.png", 82, 489); //offset +9 vertical
    
    // Show Delete Button
    renderUIButton("btn-trash.png", 213, 489); //offset +9 vertical
  
    // Color Buttons
    // Button Background
    noStroke();
    fill(59, 51, 41); 
    rect(colorsX, colorsY, 82, 32);
    
    // Current Color Selection
    fill(72, 63, 51);
    triangle(cCurrentX, cCurrentY, cCurrentX+5, 268, cCurrentX+10, 275);

    // Make Color Buttons
    for (int i = 0; i < colors.length; i++) {
       fill(colors[i]);
       rect(colorsX+colorBlockOffsetX+(colorBlock*i), colorsY+colorBlockOffsetY, colorBlock, colorBlock);
    }
    
  }
}

/* Utility functions
------------------------------------------------------------ */

// Render the UI background
void renderUIBackground() {
  noStroke();
  fill(72, 63, 51); // BG
  rect(uiX, uiY, uiW, uiH);
}

// Render a UI button
void renderUIButton(String btnFile, int btnX, int btnY) {
  PImage btnNew; 
  btnNew = loadImage(btnFile);
  image(btnNew, btnX, btnY);
}

// Save an image
void saveImage() {
  PImage sImage;
  sImage = get(0, 0, captureW, captureH);
  sImage.save("beard-" + timestamp() + ".png");  
}

// Create a timestamp
String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS%1$tL", now);
}

