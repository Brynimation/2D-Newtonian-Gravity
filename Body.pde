class Body{
  float mass;
  float radius;
  float G = 6.67 * (float) Math.pow(10, -3); //real value is 6.67 * 10^-11
  PVector position;
  PVector velocity;
  PVector acceleration;
  PVector force;
  color colour = 255; 
  boolean selected;
  
  public Body(float mass, float radius, float x, float y){
    this.mass = mass;
    this.radius = radius;
    this.position = new PVector(x, y);
    this.velocity = new PVector(0, 0);
    this.acceleration = new PVector(0, 0);
  }
  
  void attract(Body b)
  {
    PVector displacement = PVector.sub(b.position, this.position);
    PVector direction = displacement.normalize(null);
    float dSq = direction.magSq();
    float forceMag = G * this.mass * b.mass / dSq;
    this.force = (forceMag > 0.0001 ) ? direction.mult(forceMag) : new PVector(0,0);
    applyForce(this.force);
  }
  void attractMultiple(ArrayList<Body> bodies)
  {
    for(Body b : bodies) if(!b.equals(this)) this.attract(b);
    if(bodies.size() == 1 && this.force != null) this.applyForce(this.force);
  }

  
  void applyForce(PVector force)
  {
    acceleration = force.div(this.mass);
    velocity.add(acceleration);
    position.add(velocity);
  }
  void display()
  {
    fill(colour);
    ellipse(position.x, position.y, radius, radius);
   
  }
  
  void selected()
  {
    if(!selected)
    { 
      colour =128;;
      selected = false;
    } else {
      colour =255;;
      selected = true;
    }

  }
}
