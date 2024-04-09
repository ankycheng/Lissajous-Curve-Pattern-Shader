precision mediump float;

uniform float uTime;
uniform vec2 uResolution;
uniform vec2 uMouse;

// Function to draw a Lissajous figure
// Returns true if the current fragment is on the path, false otherwise
bool drawLissajous(in vec2 uv, in float time, in vec2 frequency, in float delta) {
  float A = 0.5, B = 0.5; // Amplitude
  float pathLength = 0.01; // Thickness of the path

  // Loop through 'time' to draw the path
  for(float t = 0.0; t <= 5.0; t += 0.01) {
    vec2 lissajous = vec2(A * sin((frequency.x) * t + uv.x + delta), B * sin(frequency.y * t));
    if(length(uv - lissajous) < pathLength) {
      return true;
    }
  }
  return false;
}

void main() {
  float numCellsX = 3.0;
  float numCellsY = 3.0;

  vec2 cellIndex = floor((gl_FragCoord.xy / uResolution.xy) * vec2(numCellsX, numCellsY));
  vec2 cellSize = vec2(2.0 / numCellsX, 2.0 / numCellsY);
  vec2 uv = (gl_FragCoord.xy - cellIndex * (uResolution.xy / vec2(numCellsX, numCellsY)) - 0.5 * (uResolution.xy / vec2(numCellsX, numCellsY))) / (uResolution.y / numCellsY);
  // size of the cell
  uv *= 2.0;

  // Adjust frequency based on cell index for variation across the grid
  float speed = 0.5;
  vec2 frequency = vec2(1.0 , 1.0 ) + cellIndex * 0.5;
  float delta = 0.1 + cellIndex.x * 0.05 - cellIndex.y * 0.05 + uTime/1.0;

  // Call the drawLissajous function
  bool onPath = drawLissajous(uv, uTime, frequency, delta);

  // Set the fragment color based on the function's return value
  if(onPath) {
    gl_FragColor = vec4(0.98, 0.98, 0.98, 1.0);
  } else {
    gl_FragColor = vec4(0.0, 0.0, 0.0, 1.0);
  }
}