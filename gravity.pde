import java.util.ArrayList;
ArrayList<Body> bodies;
Body body1;
int num = 0;
int mass;
int radius;
int first;
int centreX;
int centreY;
boolean beingDragged;
float translateX = 0;
float translateY = 0;


void setup()
{
  size(800, 450);
  background(0);
  body1 = new Body(10, 10, 10, 10);
  bodies = new ArrayList<Body>();
  bodies.add(body1);
}

void keyPressed()
{
  if(key == 'z' && bodies.size() > 0) bodies.remove(bodies.size()-1);
}
void draw()
{
  translate(translateX, translateY);
  background(0);
  for(Body b : bodies)
  {
    b.attractMultiple(bodies);
    b.display();
    //if (checkDist(b)) bodies.remove(b);
  }  
}
boolean checkDist(Body b)
{
  if(b.position.x < -1000 || b.position.x > width + 1000) return true;
  else if (b.position.y < -1000 || b.position.y > height + 1000) return true;
  else return false;
}

void mouseDragged()
{
  beingDragged = true;

   if(num == 0)
   {
     centreX = mouseX;
     centreY = mouseY;
   }else{
    int x = Math.abs(mouseX - centreX);
    int y = Math.abs(mouseY - centreY);
    radius = (int) Math.sqrt(x*x + y*y);
    ellipse(centreX, centreY, radius, radius);
   }
   num++;
   
}
void mouseReleased()
{
  Body newBody;
  if(beingDragged){
    newBody = new Body(radius, radius, centreX,centreY);
    bodies.add(newBody);
    centreX = 0;
    centreY = 0;
    radius = 0;
    num = 0;
    beingDragged = false;
  }else{
    newBody = new Body(10, 10, mouseX, mouseY);
    bodies.add(newBody);
  }
  
}
