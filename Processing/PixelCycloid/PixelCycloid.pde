
/* PixelCycloid
 * This program animates a hypocycloid (a circle rolling inside a larger circle)
 * It also includes a GUI for controlling the inner circle's rotation speed and size
 * Additionally, it includes the option to "pixelate" the resulting animation, giving a "pixel art" effect
 * Finally, pressing SPACE will hide or reveal the GUI
 */

boolean recording = false;
PGraphics pg;

int FRAMES = 100;
float r1, r2;

int w = 5;
int h = w;

int n = -3;
float factor = 0.25;

boolean pixelate = true;
boolean showControls = true;

void setup() {
  size(600, 600);
  frameRate(24);
  
  textSize(25);
  textAlign(CENTER, CENTER);

  pg = createGraphics(600, 600);
  pg.ellipseMode(RADIUS);

  // Inner and outer radii
  r1 = min(width, height) / 3;
  r2 = r1 * factor;
}

void draw() {
  background(50);
  pg.beginDraw();
  pg.background(50);

  pg.translate(width/2, height/2);
  float step = TWO_PI / FRAMES;
  float t = (frameCount * step) % TWO_PI;

  pg.noFill();
  pg.stroke(255);
  pg.strokeWeight(8);

  pg.circle(0, 0, r1 * 2);

  float x1 = 0, y1 = 0, x2 = 0, y2 = 0;
  pg.beginShape();
  for (float a = 0; a <= t; a += 0.01) {
    x1 = (r1 - r2) * cos(a);
    y1 = (r1 - r2) * sin(a);

    x2 = x1 + r2 * cos(n * a);
    y2 = y1 + r2 * sin(n * a);
    pg.vertex(x2, y2);
  }

  pg.circle(x1, y1, r2 * 2);
  pg.line(x1, y1, x2, y2);
  pg.stroke(255, 0, 0);
  pg.endShape();
  
  pg.stroke(0, 255, 0);
  pg.strokeWeight(14);
  pg.point(x2, y2);

  // A very basic pixelation algorithm.
  // All it does is draw solid color squares about 5 times as large as each pixel
  if (pixelate) {
    noStroke();
    pg.loadPixels();
    for (int x = 0; x < width; x += w) {
      for (int y = 0; y < height; y += h) {
        fill( pg.pixels[x + y * width] );
        rect(x, y, w, h);
      }
    }

  }
  pg.endDraw();

  if (!pixelate)
    image(pg, 0, 0, width, height);

  if (showControls) {
    // Draw the left-most GUI menu
    push();
    translate(15, 15);
    drawGUI();
    pop();
    
    // Draw the right-most GUI menu
    push();
    translate(width - 115, 15);
    drawGUI();
    pop();
    
    fill(0);
    text("n = " + n, 65, 65);
    text(String.format("s = %.2f", factor), width - 65, 65);
    
    // Draw the pixelation checkbox
    stroke(255);
    strokeWeight(10);
    rect(15, height - 65, 50, 50);
    
    // Draw a green check, when appropriate
    if (pixelate) {
      stroke(0, 200, 0);
      strokeWeight(10);
      
      line(15, height - 40, 40, height - 15);
      line(40, height - 15, 65, height - 65);
    }
  }

  if (recording && frameCount <= FRAMES)
    saveFrame("output/gif-###.png");
  else if (recording) {
    println("Done.");
    exit();
  }
}

void drawGUI() {
  /* This method draws the GUI menus that display and control:
  - rotation speed (n)
  - size (s)
  */

  // White display box
  fill(200);
  strokeWeight(4);
  stroke(255, 100, 0);
  rect(0, 35, 100, 40);

  noStroke();
  // Green "up" box
  fill(50, 200, 50);
  rect(0, 0, 100, 25);

  // Red "down" box
  fill(200, 50, 50);
  rect(0, 85, 100, 25);

  // Black triangles
  fill(0);
  triangle(50, 5, 35, 20, 65, 20);
  triangle(50, 105, 35, 90, 65, 90);
}

void mouseClicked() {
  /* This method is automatically called when the mouse clicks inside the screen.
  It is used to control many features, such as rotation speed, size, and whether to pixelate the screen.
  */

  // Checks if the user clicked the left-most GUI menu
  // Clicking green and red boxes increment and decrement the rate of speed,
  // while clicking the white box will negate whatever value is currently set.
  if (mouseX > 15 && mouseX < 115) {
    if (mouseY > 15 && mouseY < 40)
      n += 1;
    else if (mouseY > 100 && mouseY < 125)
      n -= 1;
    else if (mouseY > 50 && mouseY < 90)
      n *= -1;
  }
  
  // Checks if the user clicked the right-most GUI menu
  if (mouseX > width - 115 && mouseX < width - 15) {
    if (mouseY > 15 && mouseY < 40 && factor < 1)
      factor += 0.05;
    else if (mouseY > 100 && mouseY < 125 && factor > 0.05)
      factor -= 0.05;

    // Upon updating the scale factor, use it
    r2 = r1 * factor;
  }
  
  // Checks if the user clicked the pixelation checkbox
  if (mouseX > 15 && mouseX < 65)
    if (mouseY > height - 65 && mouseY < height - 15)
      pixelate = !pixelate;
}

void keyPressed() {
  if (keyCode == 32)
    showControls = !showControls;
}
