let colors = ["red", "orange", "green", "blue", "purple"];
let radius;

// when this is true, the animation stops after one loop
// to make it easier to port to an "ininite loop" via screen recorder
let stop_anim = false;

function setup() {
  createCanvas(windowWidth, windowHeight, WEBGL);
  radius = min(windowWidth, windowHeight) / 4;
  noStroke();
}

function draw() {
  background(220);

  rotateX(frameCount / 250);
  rotateY(frameCount / 250);
  ambientLight(255);

  let i = 0;
  for (let t = 0; t < PI; t += TWO_PI / 25) {
    let z = sin(t) * radius;
    let r = cos(t) * radius;

    let c = colors[i % 5];
    ambientMaterial(c);
    i += 1;

    push();
    translate(0, 0, z);
    torus(r, 1);

    translate(0, 0, -z * 2);
    torus(r, 1);
    pop();
  }

  // stop looping when the animation is finished
  if (stop_anim && frameCount / 250 > PI)
    noLoop();
}
