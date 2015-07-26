import ddf.minim.*;
import ddf.minim.analysis.*;

PVector velocity = new PVector(0.01, 0.01);
PVector offset = new PVector(0.0, 50.0);

boolean running = false;

Minim minim;
AudioPlayer player;
AudioMetaData meta;
BeatDetect beat;

float radius = 40;
int stepper;

void setup() {
  size(1280, 740);
  drawBackground();
  noStroke();
  
  minim = new Minim(this);
  player = minim.loadFile("file.mp3");
  beat = new BeatDetect();  
}

void drawBackground() {
  background(0);
  stroke(100);
  noFill();
  for(int i = 10; i < sqrt(pow(width,2) + pow(height,2)); i += 30*2)
  {
     ellipse(width/2, height/2, i, i);
  }
}

void draw()
{

  if(running)
  {   

    if (stepper >= 600)
    {
     drawBackground();
     stepper = 0;
    }
     
    stepper++;
    beat.detect(player.mix);
    PVector location = new PVector(noise(offset.x)*(width/1.2), noise(offset.y)*height);
  
    offset.add(velocity);
  
    fill(150, 150, 150, 30);
    stroke(255);
    
    if (beat.isOnset())
    {
       radius = radius*1.1; 
    } else 
    {
      radius = 40;
    }
    
    ellipse(location.x,location.y, radius, radius);
    ellipse(width-location.x, location.y, radius, radius);
    
  }
  
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
    drawBackground();
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
