
color RED = color(255, 0, 0);
color GREEN = color(0, 255, 0);

class Point {
  PVector finalPos, pos, vel, acc;
  boolean danger;
  
  Point(float x, float y) {
    finalPos = new PVector(x, y);
    pos = new PVector(x, y);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    
    danger = false;
  }
  
  void interact(PVector mouse) {
    if (mouse.dist(pos) <= 50) {
      danger = true;
      
      PVector away = PVector.sub(pos, mouse);
      away.setMag(5);
      acc.add(away);
    }
    
    PVector home = PVector.sub(finalPos, pos);
    float d = constrain(pos.dist(finalPos), 0, 100);
    home.setMag(d / 100);
    acc.add(home);
  }
  
  void display() {
    stroke(danger ? RED : GREEN);
    point(pos.x, pos.y);
  }
  
  void update() {
    pos.add(vel);
    vel.add(acc);
    
    if (danger && pos.dist(finalPos) < 10 && vel.mag() < 1)
      danger = false;
    
    acc.mult(0);
    vel.mult(0.9);
  }
}
