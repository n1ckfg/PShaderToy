void setup() { 
  size(960, 540, P2D);
  noStroke();
  ellipseMode(CENTER);
  setupShaders();
}

void draw() {
  background(0);
  float size = 50.0 + (10.0 * sin(millis()/100.0));
  
  fill(255,0,0);
  ellipse(width/2, height/2, size, size);
  
  fill(0, 255, 0);
  ellipse(0, 0, size, size);
  ellipse(width, 0, size, size);
  ellipse(0, height, size, size);
  ellipse(width, height, size, size);

  fill(0, 255, 255);
  ellipse(width/4, height/4, size, size);
  ellipse(width/4, 3 * (height/4), size, size);
  ellipse(3 * (width/4), height/4, size, size);
  ellipse(3 * (width/4), 3 * (height/4), size, size);
  
  runShaders();
}