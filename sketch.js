let theShader;

function preload() {
  theShader = loadShader("vert.glsl", "frag.glsl");
}

function setup() {
  // Create a canvas with WebGL
  const w = min(windowWidth, windowHeight);
  createCanvas(w, w, WEBGL);
  noStroke();
}

function draw() {
  // Shader setup
  shader(theShader);

  // Pass uniforms to the shader
  theShader.setUniform("uTime", millis() / 1000.0);
  theShader.setUniform("uResolution", [width, height]);
  theShader.setUniform("uMouse", [(mouseX/width)*2 -1.0, (mouseY/height)*2 -1.0]);

  // Draw a quad covering the entire canvas
  quad(-1, -1, 1, -1, 1, 1, -1, 1);
}
