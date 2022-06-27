let grid = [];
let rows, cols;
let rez = 20;

function setup() {
  createCanvas(windowWidth, windowWidth);
  rows = 1 + height / rez;
  cols = 1 + width / rez;
  
  grid = [];
  for (let i = 0; i < rows; i++)
    grid[i] = [];
 
  for (let i = 0; i < rows; i++)
    for (let j = 0; j < cols; j++)
      grid[i][j] = round( noise(i/10, j/10) );
  
  noLoop();
  frameRate(5);
}

function draw() {
  background(125);

  stroke(255);
  strokeWeight(2);
  for (let i = 0; i < rows - 1; i++)
    for (let j = 0; j < cols - 1; j++) {
      let x = i * rez;
      let y = j * rez;

      let a = createVector(x + rez/2, y);
      let b = createVector(x + rez, y + rez/2);
      let c = createVector(x + rez/2, y + rez);
      let d = createVector(x, y + rez/2);

      let state = getState(grid[i][j], grid[i + 1][j],
          grid[i + 1][j + 1], grid[i][j + 1]);

      switch (state) {
        case 1:
        case 14:
            drawLine(c, d); break;
        case 2:
        case 13:
            drawLine(b, c); break;
        case 3:
        case 12:
            drawLine(b, d); break;
        case 4:
        case 11:
            drawLine(a, b); break;
        case 5:
             drawLine(a, d);
             drawLine(b, c);
             break;
         case 6:
         case 9:
             drawLine(a, c); break;
         case 7:
         case 8:
             drawLine(a, d); break;
         case 10:
             drawLine(a, b);
             drawLine(c, d);
             break;
      }

      let xoff = i/10 + frameCount/10;
      let yoff = j/10;
      grid[i][j] = round( noise(xoff, yoff) );

    }
}

function getState(a, b, c, d) {
  return a * 8 + b * 4 + c * 2 + d * 1;
}

function drawLine(v1, v2) {
  line(v1.x, v1.y, v2.x, v2.y);
}

function mouseClicked() {
  isLooping() ? noLoop() : loop();
}
