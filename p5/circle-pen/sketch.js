let FRAMES = 500;
let INCREMENT;

let counter, btn;
let opacity = 255;
let timer = 0;

function setup() {
  createCanvas(400, 400);
  INCREMENT = TWO_PI / FRAMES;
  counter = createSlider(2, 8, 2);
  btn = createButton("Restart");
  btn.mousePressed(restart);
}

function draw() {
  background(0);
  translate(width/2, height/2);
  rotate(PI/2);

  let count = counter.value();
  let x1, y1, x2, y2;

  beginShape();
  for (let t = 0; t <= timer; t += INCREMENT) {
    x1 = 100 * cos(t);
    y1 = 100 * sin(t);

    x2 = x1 + 50 * cos(count*t);
    y2 = y1 + 50 * sin(count*t);
    if (t <= TWO_PI + INCREMENT)
      vertex(x2, y2);
  }

  strokeWeight(4);
  stroke(255, opacity);
  noFill();

  stroke(255);
  circle(0, 0, 200);
  circle(x1, y1, 100);

  stroke(0, 255, 255);
  line(0, 0, x1, y1);
  line(x1, y1, x2, y2);

  stroke(255, 0, 0);
  endShape();

  timer += INCREMENT;
  if (timer >= INCREMENT + TWO_PI && opacity > 100)
    noLoop();
    // opacity -= (200 / FRAMES);

  if (timer >= TWO_PI * 2) {
    restart();
    noLoop();
  }

  noStroke();
  fill(255);
  rotate(-PI/2);

  let txt = `Outer rotations: ${count}`;
  textAlign(CENTER);
  text(txt, 0, 195);
}


function restart() {
  timer = 0;
  opacity = 255;
  if ( !isLooping() )
    loop();    
}
