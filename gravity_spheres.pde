Sphere[] mySphere;
int sphereAmount = 10;
int sp = 50;


void setup() {
  size(800, 600);
  background(255);
  smooth();
  
  //class setup
  mySphere = new Sphere[sphereAmount];
  for (int i = 0; i < sphereAmount; i++) {
    float x = random(sp / 2, width - sp / 2);
    float y = random(sp / 2, height - sp / 2);
    mySphere[i] = new Sphere(x, y);
  }
}

void draw() {
  background(255);
  for (int i = 0; i < sphereAmount; i++) {
    mySphere[i].step();
    for(int j = 0; j < i; j++) {
      float distance = dist(mySphere[i].x, mySphere[i].y, mySphere[j].x, mySphere[j].y);
      if (distance < sp) {
        float incXHolder = mySphere[i].incX;
        float incYHolder = mySphere[i].incY;
        mySphere[i].collisionHandler(mySphere[j].incX, mySphere[j].incY);
        mySphere[j].collisionHandler(incXHolder, incYHolder);
      }
      if (distance < sp-5) {
        mySphere[i].randPos();
        mySphere[j].randPos();
      }
    }
    mySphere[i].drawBall();
  }
}


class Sphere {
  float x;
  float y;
  float incX;
  float incY;
  
  int c;

  //constructor
  Sphere(float _x, float _y) {
    x = _x;
    y = _y;
    setInc();
    c = 0;
  }
  
  //speed
  void setInc() {
    incX = random(-2, 2);
    incY = random(-2, 2);
  }
  
  //reset
  void randPos() {
    x = random(sp/2,width-sp/2);
    y = random(sp/2,height-sp/2);
    c = 255;
  }
  
  //the ball
  void drawBall() {
    noStroke();
    fill(c);
    ellipse(x, y, sp, sp);
  }
  
  //direction
  void step() {
    if (x > width-sp/2 || x < sp/2) {
      incX = -incX;
    }
    if (y > height-sp/2 || y < sp/2) {
      incY = -incY;
    }
    x = x + incX;
    y = y + incY;
  }
  
  //collision
  void collisionHandler(float _incX, float _incY) {
    incX = _incX;
    incY = _incY;
    c = 0;
  }
}
