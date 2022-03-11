class Rev {
  PVector location;
  PVector velocity; 
  PVector acceleration;
  float mass;
  float maxSpeed; 
  float maxForce; 
  float G = 0.4; 
  float radius;
  color revColor;
  //alpha value as the indicator of strength
  int alphaVal; 



  Rev(float _mass, float _x, float _y) {
    mass = _mass;
    radius = 20*mass; 
    location = new PVector(_x, _y); 
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    maxSpeed = .001;
    maxForce = 0.003; 
    revColor = color(217, 32, 38, alphaVal);
  }


  // apply force function
  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass); 
    f.limit(maxForce);
    acceleration.add(f);
  }


  //attraction function
  PVector attract(Rev r) {
    PVector force = PVector.sub(location, r.location);
    float distance = force.mag();
    distance = constrain(distance, 5.0, 25.0);
    force.normalize();
    float strength = (G * mass * r.mass) / (distance * distance);
    force.mult(strength);



    return force;
  }

  // The elite are attracted to the revolutionaries, to subtract a bit of their strength 
  PVector attractElite(Elite e) {
    PVector force = PVector.sub(location, e.location);
    float distance = force.mag();
    distance = constrain(distance, 5.0, 25.0);
    force.normalize();
    float strength = (G * mass * e.mass) / (distance * distance);
    force.mult(strength);
    return force;
  }


  //rev-rev collisions
  void checkLikeCollisions(Rev r1, Rev r2) {
    //Pythagorean theorem to check for collisions 
    PVector vectorBtwnCenters = PVector.sub(r1.location, r2.location); 
    float distBtwnCenters = vectorBtwnCenters.mag(); 

    //upon collision:
    if (distBtwnCenters <= r1.radius + r2.radius) {

      //they bounce off
      r1.velocity.mult(-1);
      r2.velocity.mult(-1);



      //if the revs are still weaker than the predator (mass < 50) then increment their mass and the alpha value
      if (r1.mass <= 50 || r2.mass <= 50) {

        r1.mass += 0.1;
        r2.mass += 0.1;
        alphaVal += 1;
        //when the strength of the rev = that of the dictator, they will have the same color (full opacity)
        if (r1.mass >= 50) {
          r1.alphaVal = 255;
        }
        if (r2.mass >= 50) {
          r2.alphaVal = 255;
        }
        //alpha value as a visual cue
        revColor = color(217, 32, 38, alphaVal);
      }
    }
  }


  //Rev-dictator collisions
  void checkDictatorCollisions(Rev r, Dictator dict) {
    PVector vectorBtwnCenters = PVector.sub(r.location, dict.location); 
    float distBtwnCenters = vectorBtwnCenters.mag(); 

    if (distBtwnCenters <= r.radius + dict.shapeWidth  && r.mass <= 50) {
      //remove revolutionaries form arrayList (death) if they're too "weak" to bounce of dictator 
      revs.remove(r);
      //otherwise, they just bounce off
    } else if (distBtwnCenters <= r.radius + dict.shapeWidth && r.mass >= 50) {
      r.velocity.mult(-1);
      dict.velocity.mult(-1);
    }
  }


  //Elite-Rev collisions
  void checkEliteCollisions(Rev r, Elite e) {
    PVector vectorBtwnCenters = PVector.sub(r.location, e.location); 
    float distBtwnCenters = vectorBtwnCenters.mag(); 
    //upon collisions they bounce off
    if (distBtwnCenters <= r.radius + e.shapeWidth) {
      r.velocity.mult(-1);
      e.velocity.mult(-1); 

      //any interaction with an elite, reduces the revolutionary's strength, achieved through a decrease in mass
      //the alpha value is also decreased for the visual cue
      r.mass -= 0.2;
      alphaVal -= 2;
    }
  }

  //a seek function where the revolutionaries that are "too weak" seek shelter - it also applies the arrive functionality so things don't get too chaotic within the shelter
  void seekShelter(Rev r, PVector target) {
    if (r.mass < 50) {

      PVector desired = PVector.sub(target, location);
      float d = desired.mag();
      desired.normalize();
      if (d<100) {
        float m = map(d, 0, 200, 0, maxSpeed);
        desired.mult(m);
      } else {
        desired.mult(maxSpeed);
      }


      PVector steer = PVector.sub(desired, velocity);

      // Limit the magnitude of the steering force.
      steer.limit(maxForce);

      applyForce(steer);
    }
  }
  
  
  //a function to escape the dictator's attraction, revereses seek functionality
  void fleeDictator(Rev r, Dictator dict, PVector target) {
    if (r.mass < dict.mass) {
      PVector desired = PVector.sub(target, location);
      desired.normalize();
      desired.mult(maxSpeed);
      PVector steer = PVector.sub(desired, velocity);

      // Limit the magnitude of the steering force.
      steer.limit(maxForce);
      steer.mult(-1); 

      applyForce(steer);
    }
  }



  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
  }

  void display() {
    stroke(0); 
    strokeWeight(3);
    fill(revColor);
    ellipseMode(RADIUS);
    ellipse(location.x, location.y, radius, radius);
  }

  //bouncing off edges of the screen
  void checkEdges() {
    if (location.x < width - radius) {
      velocity.x *= -1;
    } else if (location.x > 0 + radius) {
      velocity.x *= -1;
    }

    if (location.y > height - radius) {
      velocity.y *= -1;
    } else if (location.y < 0 + radius) {
      velocity.y *= -1;
    }
  }
}
