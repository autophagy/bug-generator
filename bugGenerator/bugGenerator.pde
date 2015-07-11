PVector velocity = new PVector(0.01, 0.01);
PVector offset = new PVector(0.0, 50.0);

boolean running = false;

void setup() {
  size(640, 360);
  drawBackground();
  noStroke();
  
}

void drawBackground() {
  background(0);
  stroke(255);
  noFill();
  for(int i = 10; i < sqrt(pow(width,2) + pow(height,2)); i += 30)
  {
     ellipse(width/2, height/2, i, i);
  }
}

void draw()
{

  if(running)
  {
    PVector location = new PVector(noise(offset.x)*(width/1.2), noise(offset.y)*height);
  
    offset.add(velocity);
  
    fill(150, 150, 150, 30);
    stroke(255);
    float radius = noise(offset.x)*64;
    ellipse(location.x,location.y, radius, radius);
    ellipse(width-location.x, location.y, radius, radius);
  }
  
}

void keyPressed() {
  if (key == ' ')
  {
    running = !running;
  }
  
  if (key == 'r')
  {
    drawBackground();
  }
}
