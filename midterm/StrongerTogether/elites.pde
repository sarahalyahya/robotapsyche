class Elite {

  float mass;
  PVector location;
  PVector velocity; 
  PVector acceleration; 
  float G; 
  float maxSpeed; 
  float maxForce; 
  int shapeWidth; 
  color eliteColor;


  Elite(float _x, float _y) {

    mass = 20; 
    location = new PVector(_x, _y); 
    velocity = new PVector(0, 0); 
    acceleration = new PVector(0.2, 0.1); 
    eliteColor = color(200, 90, 38); 
    shapeWidth = 30; 
    maxSpeed = 0.5;
    maxForce = 1.3;
  }


  //apply force function
  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass); 
    acceleration.add(f);
  }



  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
  }

  void display() {
    rectMode(RADIUS);
    stroke(0);
    fill(eliteColor); 
    rect(location.x, location.y, shapeWidth, shapeWidth, 20);
  }

  //bouncing off edges of the screen/shelter
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
  
  //for elite-elite collisions
  void checkCollisionAmongElites(Elite e1, Elite e2) {
    PVector vectorBtwnCenters = PVector.sub(e1.location, e2.location); 
    float distBtwnCenters = vectorBtwnCenters.mag(); 

    //upon collision:
    if (distBtwnCenters <= e1.shapeWidth/2 + e2.shapeWidth/2) {

      //they bounce off
      e1.velocity.mult(-1);
      e2.velocity.mult(-1);
    }
  }

  //for elite-dictator collisions
  void checkCollisionWDictator(Dictator dict, Elite e) {
    PVector vectorBtwnCenters = PVector.sub(e.location, dict.location); 
    float distBtwnCenters = vectorBtwnCenters.mag(); 

    if (distBtwnCenters <= e.shapeWidth + dict.shapeWidth ) {
      e.velocity.mult(-1); 
      dict.velocity.mult(-1);
    }
  }
}
