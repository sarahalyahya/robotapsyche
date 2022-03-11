class Dictator {
  float mass;
  PVector location;
  PVector velocity; 
  PVector acceleration; 
  float G; 
  float maxSpeed; 
  float maxForce; 
  int shapeWidth; 
  color dictColor;



  Dictator(float _x, float _y) {

    mass = 50; 
    location = new PVector(_x, _y); 
    velocity = new PVector(0, 0); 
    acceleration = new PVector(0.2, 0.1); 
    dictColor = color(217, 32, 38); 
    shapeWidth = 90; 
    maxSpeed = 1.5;
    maxForce = 1.6;
  }

  //apply force function
  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass); 
    acceleration.add(f);
  }

  //Function that seeks revolutionaries to kill them
  void seekRevs(Rev r, Dictator dict, PVector target) {
    if (r.mass < dict.mass) {
      PVector desired = PVector.sub(target, location);
      desired.normalize();
      desired.mult(maxSpeed);
      PVector steer = PVector.sub(desired, velocity);

      // Limit the magnitude of the steering force.
      steer.limit(maxForce);

      applyForce(steer);
    }
  }

  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
  }

  void display() {
    rectMode(RADIUS);
    noStroke();
    fill(dictColor); 
    rect(location.x, location.y, shapeWidth, shapeWidth, 20);
  }

  //bouncing off edges of the screen/ shelter
  void checkEdges() {
    if (location.x > width - shapeWidth) {
      velocity.x *= -1;
    } else if (location.x < 400 + shapeWidth) {
      velocity.x *= -1;
    }

    if (location.y > height - shapeWidth) {
      velocity.y *= -1;
    } else if (location.y < 0 + shapeWidth) {
      velocity.y *= -1;
    }
  }
}
