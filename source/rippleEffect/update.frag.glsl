#version 300 es
precision mediump float;
in vec2 st;
uniform sampler2D currentSampler;
uniform sampler2D beforeSampler;
out vec4 fragment;

void main() {
  // sample the pixel on the current frame
	float c = texture(currentSampler, st).r;

	// sample the neighboors
	float d = 0.0005f;
	float a = 0.0f;
	a += texture(beforeSampler, vec2(st.s - d, st.t)).r;
	a += texture(beforeSampler, vec2(st.s + d, st.t)).r;
	a += texture(beforeSampler, vec2(st.s, st.t - d)).r;
	a += texture(beforeSampler, vec2(st.s, st.t + d)).r;
	
	// tweak the parameters a bit
	c = a * 0.5f - c;
	c = c * 0.99f;
	c = clamp(c, -5.9, 5.9);
	fragment = vec4(c, 0, 0, 1);
}
