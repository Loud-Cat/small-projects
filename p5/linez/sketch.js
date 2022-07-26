/* Linez
 * made with p5.js
 * inspired by Engare
*/

let slider = null;
let sz = 0;

function setup() {
  sz = min(windowWidth, windowHeight);
  createCanvas(sz, sz);
  textAlign(CENTER, CENTER);

  noStroke();
  slider = createSlider(-10, 10, -6);
  slider.style("width", `${sz - 25}px`);
  slider.style("height", "25px");
}

function draw() {
  background(50);
  translate(width/2, height/2);
  let s = +slider.value() / 10;
  
  let len = abs(s * sz) / 4;
  let t = (frameCount / 50) % (4 * TAU);
  let t2 = t * s * 5;
  
  noFill();
  stroke(255);
  strokeWeight(3);
  
  let x1, y1, x2, y2;
  beginShape();
  for (let a = 0; a <= t; a += 1 / 50) {
    x1 = cos(a) * 100;
    y1 = sin(a) * 100;
    let a2 = a * s * 5;
  
    x2 = x1 + cos(a2) * len;
    y2 = y1 + sin(a2) * len;
    if (a <= 2 * TAU)
     vertex(x2, y2);
  }

  if (t >= 2 * TAU)
    endShape(CLOSE);
  else
    endShape();

  stroke(0, 128, 128);
  strokeWeight(16);
  
  
  stroke(50, 128, 128);
  line(0, 0, x1, y1);

  stroke(230);
  line(x1, y1, x2, y2);
}
