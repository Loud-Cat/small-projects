
PVector[] morph;
PVector[] vertices;
boolean state = false, recording = false;

int radius = 200;
int opacity = 255;
int FRAMES = 100;
int sides = 3;

void setup() {
  size(600, 600);
  morph = new PVector[FRAMES];
  vertices = new PVector[0];

  for (int i = 0; i < morph.length; i++) {
    morph[i] = new PVector();
  }
}

void draw() {
  background(50);
  translate(width/2, height/2);
  rotate(frameCount / 100.0);

  noFill();
  stroke(255, opacity);
  strokeWeight(10);

  float total_dist = 0.0;
  for (int i = 0; i < morph.length; i++) {
    PVector v1 = state ? circlepoint(i) : polypoint(i);
    PVector v2 = morph[i];
    total_dist += PVector.dist(v1, v2);
    v2.lerp(v1, 0.05);
  }

  if (total_dist < FRAMES) {
    if (state && sides < 6)
      sides ++;

    if (sides < 6)
      state = !state;
  }

  beginShape();
  for (PVector v : morph) {
    vertex(v.x, v.y); 
  }
  endShape(CLOSE);

  if (sides == 6) {
    opacity -= 1;
    if (radius > 0)
      radius -= 1;
  }

  if (recording && opacity > 0)
    saveFrame("output/morph-###.png");

  if (opacity <= 0) {
    println("Done.");
    if (recording)
      exit();
    else
      reset();
  }

}

void reset() {
  opacity = 255;
  radius = 200;
  sides = 3;
  state = false;
}

PVector lerpPoints(PVector[] points, float amt) {
  if (points.length == 1) return points[0];

  float cunit = 1.0 / (points.length - 1);
  PVector start = points[ floor(amt / cunit) ];
  PVector end = points[ ceil(amt / cunit) ];
  return PVector.lerp(start, end, amt % cunit / cunit);
}

PVector polypoint(int i) {
  if (vertices.length != sides + 1) {
    vertices = new PVector[sides + 1];
    for (int j = 0; j < sides + 1; j++) {
      float a = map(j, 0, sides, 0, TWO_PI);
      vertices[j] = new PVector(radius * cos(a), radius * sin(a));
    }
  }

  float amt = (float) i / FRAMES;
  return lerpPoints(vertices, amt);
}

PVector circlepoint(int i) {
  float t = (float) i / FRAMES * TWO_PI;
  return new PVector(radius * cos(t), radius * sin(t));
}
