const debug = console.log.bind(console);
const error = console.error.bind(console);
const canvas = document.querySelector("canvas");
const gl = canvas.getContext("webgl2");
let lastTime;
const shaders = {};
const programs = {};
const models = {};

const requestFile = url => {
  return new Promise((resolve, reject) => {
    var request = new XMLHttpRequest();
    request.open("GET", url, true);
    request.onreadystatechange = function() {
      if (request.readyState == 4) {
        if (request.status !== 200) {
          reject(request);
        }

        resolve(request.response);
      }
    };
    request.send(null);
  });
};

const loadVertexShader = sourceCode => {
  const shader = gl.createShader(gl.VERTEX_SHADER);
  gl.shaderSource(shader, sourceCode);
  gl.compileShader(shader);
  return shader;
};

const loadFragmentShader = sourceCode => {
  const shader = gl.createShader(gl.FRAGMENT_SHADER);
  gl.shaderSource(shader, sourceCode);
  gl.compileShader(shader);
  return shader;
};

const loadShaderProgram = (vertexSource, fragmentSource) => {
  const vertexShader = loadVertexShader(vertexSource);
  const fragmentShader = loadFragmentShader(fragmentSource);
  const shaderProgram = gl.createProgram();
  gl.attachShader(shaderProgram, vertexShader);
  gl.attachShader(shaderProgram, fragmentShader);
  gl.linkProgram(shaderProgram);

  if (!gl.getProgramParameter(shaderProgram, gl.LINK_STATUS)) {
    debug("program", gl.getProgramInfoLog(shaderProgram));
    debug("vertex", gl.getShaderInfoLog(vertexShader));
    debug("fragment", gl.getShaderInfoLog(fragmentShader));
  }

  return shaderProgram;
};

const resizeCanvas = () => {
  let displayWidth = canvas.clientWidth;
  let displayHeight = canvas.clientHeight;

  if (canvas.width != displayWidth || canvas.height != displayHeight) {
    canvas.width = displayWidth;
    canvas.height = displayHeight;
  }
};

const renderFirst = () => {
  gl.enable(gl.DEPTH_TEST);
  gl.enable(gl.CULL_FACE);
  gl.cullFace(gl.BACK);
  lastTime = Date.now();
  window.requestAnimationFrame(renderFrame);
};

const renderFrame = () => {
  resizeCanvas();
  gl.viewport(0, 0, gl.drawingBufferWidth, gl.drawingBufferHeight);
  gl.clearColor(0.529, 0.808, 0.922, 1.0);
  gl.clear(gl.COLOR_BUFFER_BIT);

  gl.lineWidth(1);
  gl.useProgram(programs.default);
  gl.bindBuffer(gl.ARRAY_BUFFER, models.quad.bufferPosition);
  gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, models.quad.bufferIndices);
  gl.drawElements(
    gl.TRIANGLES,
    models.quad.bufferIndices.length,
    gl.UNSIGNED_SHORT,
    0
  );

  const nowTime = Date.now();
  const elapsedTime = nowTime - lastTime;
  // console.log({ elapsedTime });
  lastTime = nowTime;
  window.requestAnimationFrame(renderFrame);
};

const runAsync = async () => {
  if (!gl) {
    throw "failed to get gl context. your browser may does support webgl";
  }

  programs.default = loadShaderProgram(
    await requestFile("default.vert.glsl"),
    await requestFile("default.frag.glsl")
  );

  const verticesData = [
    -0.5,
    +0.5,
    +0.0,
    -0.5,
    -0.5,
    +0.0,
    +0.5,
    -0.5,
    +0.0,
    +0.5,
    +0.5,
    +0.0
  ];
  const indicesData = [3, 2, 1, 3, 1, 0];

  const bufferPosition = gl.createBuffer();
  gl.bindBuffer(gl.ARRAY_BUFFER, bufferPosition);
  gl.bufferData(
    gl.ARRAY_BUFFER,
    new Float32Array(verticesData),
    gl.STATIC_DRAW
  );

  const bufferIndices = gl.createBuffer();
  gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, bufferIndices);
  gl.bufferData(
    gl.ELEMENT_ARRAY_BUFFER,
    new Uint16Array(indicesData),
    gl.STATIC_DRAW
  );

  const model = {
    bufferPosition,
    bufferIndices
  };
  models.quad = model;

  window.requestAnimationFrame(renderFirst);
};

runAsync();
