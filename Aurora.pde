PVector v = new PVector(2, 2);
PImage pic = createImage(500, 500, RGB);

float g = 9.8;
float step = 0.1;
float diameter = 20;

float x0 = 0;
float y0 = 0;

float vx0 = 50;
float vy0 = 0;

float t = 0;

void setup() {
  size(500, 500);
  
  pic.set(250, 250, color(255, 0, 0)); //8bits color
}

//loop
void draw() {
  image(pic, 0, 0);
  //background(0);
  
  float x = x0 + vx0 * t;
  float y = y0 + vy0 * t + 0.5 * g * t * t;
  
  t += step;
  
  ellipse(x, y, diameter, diameter);
}
