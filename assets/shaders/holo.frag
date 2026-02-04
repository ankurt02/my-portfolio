#version 320 es
precision highp float;
layout(location = 0) out vec4 fragColor;

layout(location = 0) uniform float u_width;
layout(location = 1) uniform float u_height;

void main() {
    vec2 uv = gl_FragCoord.xy / vec2(u_width, u_height);

    float rainbow = sin(uv.x * 10.0) + cos(uv.y * 10.0);

    vec3 color = vec3(
        0.8 + 0.2 * sin(rainbow),
        0.8 + 0.2 * sin(rainbow + 2.0),
        0.8 + 0.2 * sin(rainbow + 4.0)
    );

    fragColor = vec4(color, 0.2);
}
