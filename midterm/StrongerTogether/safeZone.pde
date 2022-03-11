//a class for the shelter, perhaps unnecessary but allowed for better organization

class safeZone {
  color safeZoneColor = color(149, 213, 178); 

  int x = 0; 
  int y = 0; 
  int w = 400; 
  int h = height;
  PVector center = new PVector(x+w/2, y+h/2); 



  safeZone() {
  }

  void display() {
    noStroke();
    fill(safeZoneColor);
    rect(x, y, w, h);
  }
}
