/** Fourier Series
  * An animation of circles rotating around in a series
  */

// The number of frames per 2pi radians of rotation.
// Most animations are ~25fps, so this is around 15s
int FRAMES = 900;

// The mumber of points in the series
// including beginning & end
int COUNT = 6;

/** This Processing method is called at startup
  * It simply sets the screen and defines some settings
  */
void setup() {
  size(800, 800);
  ellipseMode(RADIUS);
}

/** This method is called by Processing for each frame
  */
void draw() {
  // black background
  background(0);
  
  // Make the origin at the center for convenience
  translate(width/2, height/2);
  
  // This is the time/theta variable
  // Each frame number is converted to a radian measurement
  float t = (float) frameCount / FRAMES * TWO_PI;
  t %= TWO_PI * 2;
  
  noFill();
  stroke(255);
  strokeWeight(4);
  
  // Positions and speeds of each point/circle
  PVector[] positions = new PVector[COUNT];
  int[] speeds = new int[COUNT];
  
  // Here lies the "formula" for the speed of a given circle
  // ngl I messed around until I got interesting results
  
  // Note: if you don't want to use the ternary,
  // sin(-HALF_PI + PI * i) will habe the same affect
  // but you'll have to cast it to an int
  
  for (int i = 0; i < COUNT; i++)
    speeds[i] = (i % 4) * ((i % 2 == 0) ? -1 : 1);
  
  // The "base" radius, also picked at random
  // The radius halves with each step
  // to avoid too-large drawings
  float rad = width/5;
  
  // beginShape() and endShape() are used to create shapes
  // one point at a time
  beginShape();
  
  /** This is where the bulk of it happens.
    * basically, you start at the center, then go along the
    * current circle a given amount, then use that point
    * instead of the center repeating for the next circle
    * and repeat until you're out of circles
    */
  for (float a = 0; a <= t; a += 1.0 / FRAMES * TWO_PI) {
    // The first point is special because there is no
    // "previous position"
    PVector start = new PVector(0, 0);
    positions[0] = start.copy();
    
    float r = rad;
    for (int i = 1; i < COUNT; i++) {
      // Rotated vector containing x and y to add
      // x = r * cos(t), y = r * sin(t)
      PVector rot = PVector.fromAngle(a * speeds[i]).mult(r);
      r /= 2;
      
      start.add(rot);
      positions[i] = start.copy();
    }
    
    // Only draw to the screen when you need to
    if (a <= TWO_PI * 1.1)
      vertex(start.x, start.y);
  }
  endShape();
  
  // Draw circles and straight lines
  beginShape();
  for (int i = 0; i < COUNT; i++) {
    PVector pv = positions[i];
    float r = rad / (2 * i);
    vertex(pv.x, pv.y);
    
    if (i < COUNT - 1)
      ellipse(pv.x, pv.y, r, r);
  }
  endShape();
}
