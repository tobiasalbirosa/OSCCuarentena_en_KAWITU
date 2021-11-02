import processing.video.*;
float xS1;
float xS2;
float xS3;
int mode = 0;
int recta = 0;
int rectb = 0;
int xpos = 0;
int ypos = 0;
int rgb;
float r;
PImage fondo;
PImage img1;
PImage img2;
PImage img3;
int numPixels;
int[] previousFrame;
int currR;
int currG;
int currB;
int prevR;
int prevG;
int prevB;
int diffR;
int diffG;
int diffB;
int efecto1 = 180;
int efecto2 = 180;
int efecto3 = 180;
int efecto4 = 180;
int efecto5 = 180;
int efecto6 = 180;
boolean a;
boolean b;
boolean c;
float brillo1 = 180;
float brillo2 = 180;
float brillo3 = 180;
float myAngle1 = 0;
float myAngle2 = 0;
float myAngle3 = 0;
float pos = 1;
float add1 = 1;
float add2 = 1;
float add3 = 1;
int state1;
int state2;
int state3;
float opac = 127;
float cont = 0;
float x1 = 0;
float x2 = 0;
float x3 = 0;
float y1 = 0;
float y2 = 0;
float y3 = 0;
float oscuridad = 127;
float oscuridadFondo = 120;
int movementSum = 0;
int mover = 0;
color currColor;
color prevColor;
Capture video;
void setup() {
  frameRate(6);
  noCursor();
  size(512, 256);
  rectMode(CENTER);
  ellipseMode(CENTER);
  imageMode(CENTER);
  blendMode(NORMAL);
  String cameras [] = Capture.list();
  video = new Capture(this, 512, 256, cameras[0], 30);
  video.start(); 
  numPixels = video.width * video.height;
  previousFrame = new int[numPixels];
  loadPixels();  
  colorMode(HSB);
  ellipseMode(CENTER);
  imageMode(CENTER);
  blendMode(NORMAL);
  fondo = loadImage("4.jpeg");  
}
void draw() {
  video.read();
  video.loadPixels();  
  for (int i = 0; i < numPixels; i++) {
    currColor = video.pixels[i];
    prevColor = previousFrame[i];
    currR = (currColor >> 16) & 0xFF;
    currG = (currColor >> 8) & 0xFF;
    currB = currColor & 0xFF;
    prevR = (prevColor >> 16) & 0xFF;
    prevG = (prevColor >> 8) & 0xFF;
    prevB = prevColor & 0xFF;
    diffR = abs(currR - prevR*int(pos));
    diffG = abs(currG - prevG*int(pos));
    diffB = abs(currB - prevB*int(pos));
    pixels[i] = color((diffR*add1)*(opac/100), (diffG*add2)*(opac/100), (diffB*add3)*(opac/100), 127);
    previousFrame[i] = currColor;      
    movementSum += diffR + diffG + diffB;
  }
  if (mover == 0) {      
   updatePixels();
  }  
  pushMatrix();
  translate(width/2, height/2);    
  tint(0, 0, 255, oscuridadFondo/3);
  image(fondo, 0, 0,width,height); 
  popMatrix();
  println(oscuridad);
}
void keyPressed() {
  println(opac);
  println(add1,add2,add3);
  if (key == 'n') {
    opac = opac+7;
  } else if (key == 'N') {
    opac = opac+.7;
  } else  if (key == 'm') {
    opac = opac-7;
  } else if (key == 'M') {
    opac = opac-.7;
  } else if (keyCode == LEFT) {
    pos=pos-.1;
  } else if (keyCode == RIGHT) {
    pos=pos+.1;
  } else if (keyCode == UP) {
    pos=1;
    mover = 0;
    blendMode(NORMAL);
  } else if (keyCode == DOWN) {
    blendMode(8);
    mover = 999999;
    updatePixels();
  } else if (key == 'r')
  {
    colorMode(RGB);
  } else if (key == 'R')
  {
    colorMode(HSB);
  } else if (key == 'z') {
    blendMode(0);
  } else if (key == 'x') {
    blendMode(2);
  } else if (key == '1') {
    a = !a;
  } else if (key == '2') {
    b = !b;
  } else if (key == '3') {
    c = !c;
  } else if (key == '4') {
    add1 = .2;
    add2 = 1;
    add3 = 1;
  } else if (key == '5') {
    add1 = .4;
    add2 = 1;
    add3 = 1;
  } else if (key == '6') {
    add1 = .6;
    add2 = 1;
    add3 = 1;
  } else if (key == '7') {
    add1 = .8;
    add2 = 1;
    add3 = 1;
  } else if (key == '8') {
    add1 = 1;
    add2 = 1;
    add3 = 1;
  } else if (key == '9') {
    opac = .1;
    add1 = .4;
    add2 = 1;
    add3 = 5;
  } else if (key == '0') {
    add1 = .5;
    add2 = 1;
    add3 = 10;
  }else if (key == '?') {
    add1 = .8;
    add2 = 1;
    add3 = 15;
  } else if (key == '¡') {
    add1 = .2;
    add2 = 1;
    add3 = 3;
  } else if (key == ' ') {
    add1 = .4;
    add2 = 1;
    add3 = 20;
  } else if (key == '+') {
    oscuridad=oscuridad+1;
     if(oscuridad >= 0){
      oscuridad = 255;
    }
  } else if (key == '-') {
    oscuridad=oscuridad-1;
    if(oscuridad <= 0){
      oscuridad = 1;
    }
  }
}
