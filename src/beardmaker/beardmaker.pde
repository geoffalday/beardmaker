import processing.video.*;
Capture myCapture;

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
boolean newbeard;
String mode;

void setup() {
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
  baseStart = 3;
  baseLength = 10;  
  newbeard = true;
  mode = "pose";
}

void captureEvent(Capture myCapture) {
  myCapture.read();
}

void keyPressed() {
  // Draw Key
  if (key == 'b') { 
    image(myCapture, 0, 0);
    newbeard = false;
    mode = "draw";
  }
  // Save Key
  if (key == 's') {    
    sImage = get(0, 0, 320, 240);
    sImage.save("beard-" + m + ".png");
  }
  // Trash Key
  if (key == 'n') {
    newbeard = true;
    mode = "pose";
  }
}

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
    
  }
  
  if (mode == "draw") {
    
    /// Save Button
    image(btnSave, 82, 249);
    
    // Delete Button
    image(btnTrash, 213, 249);
  
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
