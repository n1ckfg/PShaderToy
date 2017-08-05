void setup() {
  size(640, 360, P2D);
  noStroke();
  ellipseMode(CENTER);
  setupShaders();
}

void draw() {
  background(0);
  fill(255,0,0);
  float size = 50.0 + (10.0 * sin(millis()/100.0));
  ellipse(width/2, height/2, size, size);
  
  drawShaders();
}