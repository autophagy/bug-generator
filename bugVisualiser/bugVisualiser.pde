import ddf.minim.*;
import ddf.minim.analysis.*;

PGraphics bg;
PGraphics worm;

PVector velocity = new PVector(0.01, 0.01);
PVector offset = new PVector(0.0, 50.0);

boolean running = false;

boolean circles = false;

Minim minim;
AudioPlayer player;
AudioMetaData meta;
BeatDetect beat;

float radius = 40;
int stepper;

void setup() {
  size(1280, 720);

  bg = createGraphics(width, height);
  worm = createGraphics(width, height);

  drawBackground(radius);
  image(bg, 0, 0);
  noStroke();

    minim = new Minim(this);
  player = minim.loadFile("02. Archangel.mp3");
  beat = new BeatDetect();

}

void drawBackground(float x) {
  bg.beginDraw();
  bg.background(0);
  bg.stroke(100);
  bg.noFill();

  for(int i = 10; i < sqrt(pow(width,2) + pow(height,2)); i += x)
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

  if(running)
  {

  //  if (stepper >= 600)
    //{
     //worm = createGraphics(width, height);
     //stepper = 0;
    //}

    beat.detect(player.mix);

    if (beat.isOnset())
    {
       radius = radius*0.9;
    } else
    {
      radius = 40;
    }

    drawBackground(radius);

    PVector location = new PVector(noise(offset.x)*(width/1.2), noise(offset.y)*height);

    offset.add(velocity);

    worm.beginDraw();

    worm.fill(150, 150, 150, 60);
    worm.stroke(255);

    float segmentRadius = getSegmentRadius();

    worm.ellipse(location.x,location.y, segmentRadius, segmentRadius);
    worm.ellipse(width-location.x, location.y, segmentRadius, segmentRadius);

    worm.endDraw();

    image(bg, 0, 0);
    image(worm, 0, 0);

    stepper++;
  }

}

float getSegmentRadius()
{
   int bufferSize = player.bufferSize();

   float maxValue = abs(player.mix.get(0)*100);

   for (int i = 0; i < bufferSize; i+= 20)
   {
      float val = abs(player.mix.get(i))*100;
      if(val > maxValue) maxValue = val;
   }


   return maxValue;
}

void keyPressed() {
  if (key == ' ')
  {
    running = !running;
    stepper = 0;
    togglePlayer();
  }

  if (key == 'r')
  {
    worm = createGraphics(width, height);
  }
  
  if (key == '1')
  {
    circles = true;
  }

  if (key == '2')
  {
    circles = false;
  }
}

void togglePlayer() {
   if(running)
  {
    player.play();
  } else
  {
    player.pause();
  }
}
