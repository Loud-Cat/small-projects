
ArrayList<Point> points;

void setup() {
  size(600, 600);
  
  points = new ArrayList<Point>();
  
  for (float a = 0; a < TWO_PI; a += TWO_PI / 100) {
    float x = 300 + 200 * cos(a);
    float y = 300 + 200 * sin(a);
    points.add( new Point(x, y) );
  }
}

void draw() {
  background(0);
  
  stroke(255);
  strokeWeight(10);
  
  PVector mouse = new PVector(mouseX, mouseY);
  for (Point p : points) {
    p.display();
    p.interact(mouse);
    p.update();
  }
  
  stroke(255);
  triangle(mouseX, mouseY, mouseX, mouseY + 5, mouseX + 3, mouseY + 3);
  
  if (frameCount < 400)
    saveFrame("output/frame-####.png");
  else
    exit();
}
