PVector velocity = new PVector(0.01, 0.01);
PVector offset = new PVector(0.0, 50.0);

boolean running = false;

PGraphics bg;
PGraphics worm;

boolean circles = true;

int step = 1;

void setup() {
  size(640, 360);
  bg = createGraphics(width, height);
  worm = createGraphics(width, height);
  drawBackground();
  noStroke();

  image(bg, 0, 0);
}

void drawBackground() {
  bg.beginDraw();
  bg.background(0);
  bg.stroke(100);
  bg.noFill();
  for(int i = 10; i < sqrt(pow(width,2) + pow(height,2)); i += 30)
  {
    if(circles)
    {
      bg.ellipse(width/2, height/2, i, i);
    } else
    {
      bg.quad(width/2,height/2+i, width/2+i,height/2, width/2,height/2-i, width/2-i,height/2);
    }

  }

  bg.endDraw();
}

void draw()
{

  drawBackground();

  worm.beginDraw();

  if(running)
  {

    for(int i = 1; i <= step; i++)
    {
      PVector location = new PVector(noise(offset.x)*(width/1.2), noise(offset.y)*height);

      offset.add(velocity);

      worm.fill(150, 150, 150, 30);
      worm.stroke(255);
      float radius = noise(offset.x)*64;
      worm.ellipse(location.x,location.y, radius, radius);
      worm.ellipse(width-location.x, location.y, radius, radius);
    }

  }

  worm.endDraw();

  image(bg, 0, 0);
  image(worm, 0, 0);
}

void keyPressed() {
  if (key == ' ')
  {
    running = !running;
  }

  if (key == '1')
  {
    circles = true;
  }

  if (key == '2')
  {
    circles = false;
  }

  if (key == '+')
  {
    step++;
  }

  if (key == '-')
  {
    step--;
  }

  if (key == 'r')
  {
    worm = createGraphics(width, height);
  }
}
