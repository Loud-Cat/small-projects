/* Mechanical Arms
 * Run the sketch to see the drawing in action
*/

// t1 and rt1 have offsets so they draw different things
let t, t1;
let rt, rt1;
let p, p1;

function setup() {
  createCanvas(400, 400);

  // t (time) of the first outer "arms"
  t = 0;
  t1 = PI;

  // rotation time of the spinning outer "arms"
  rt = 0;
  rt1 = PI / 2;

  // lists of points to draw each frame
  p = [];
  p1 = [];

  // black fill, stroke size 5
  fill(0);
  strokeWeight(5);
}

function draw() {
  // Black background; make the origin the center (cartesian plane)
  background(0);
  translate(width / 2, height / 2);
  scale(1, -1);

  // Rotate the first arm around the center
  let x1 = 100 * cos(t);
  let y1 = 100 * sin(t);

  // As well as the second
  let x2 = 100 * cos(t1);
  let y2 = 100 * sin(t1);

  // Rotate the next arms along those
  let cx1 = x1 + (50 * cos(2 * rt));
  let cy1 = y1 + (50 * sin(2 * rt));

  // As the animation goes on, limit the number
  // of frames to add once the drawing is finished
  if (p.length < TWO_PI / 0.025 + 1)
    p.push( createVector(cx1, cy1) );

  // Draw the cyan path
  stroke(0, 255, 255);
  for (let i = 1; i < p.length; i++) {
    let a = p[i - 1];
    let b = p[i];
    line(a.x, a.y, b.x, b.y);
  }

  // Same for the next arm
  let cx2 = x2 + (50 * cos(2 * rt1));
  let cy2 = y2 + (50 * sin(2 * rt1));

  if (p1.length < TWO_PI / 0.025 + 1)
    p1.push( createVector(cx2, cy2) );

  // Draw the magenta path
  stroke(255, 0, 255);
  for (let i = 1; i < p1.length; i++) {
    let a = p1[i - 1];
    let b = p1[i];
    line(a.x, a.y, b.x, b.y);
  }
  stroke(255);

  // Finaly, add finishing touches to it look like arms
  line(0,0, x1, y1);
  line(0,0, x2, y2);
  line(x1, y1, cx1, cy1);
  line(x2, y2, cx2, cy2);

  circle(cx1, cy1, 12);
  circle(x1, y1, 12);

  circle(cx2, cy2, 12);
  circle(x2, y2, 12);

  circle(0,0, 12);

  // Time goes on
  t += 0.025;
  t1 += 0.025;

  // So does rotation time
  rt += 0.05;
  rt1 += 0.05;
  
  // Reset t values after each loop
  if (t > TWO_PI) {
    t = 0;
    t1 = PI;

    rt = 0;
    rt1 = PI / 2;
  }
}
