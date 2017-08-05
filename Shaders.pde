PShader shader;
  
void setupShaders() {
  shader = loadShader("test.glsl"); 
  sizeToShader(shader);
}

void drawShaders() {
  mouseToShader(shader);
  timeToShader(shader);
  filter(shader);
}

void sizeToShader(PShader ps) {
  ps.set("iResolution", float(width), float(height));
}

void mouseToShader(PShader ps) {
  float mx = float(mouseX);
  float my = float(mouseY);
  float pmx = float(pmouseX);
  float pmy = float(pmouseY); 
  ps.set("iMouse", mx, my, pmx, pmy);
}

void timeToShader(PShader ps) {
  ps.set("iGlobalTime", float(millis()));
}