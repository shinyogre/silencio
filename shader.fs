#ifdef GL_ES
precision mediump number;
#endif

#define PI 3.14159265359

extern float timer;
//extern vec2 mouse;

float plot(vec2 texture_coords, float pct)
{
  return smoothstep(pct-0.02, pct, texture_coords.y) - smoothstep(pct, pct+0.02, texture_coords.y);
}

vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords )
{
  texture_coords = screen_coords/love_ScreenSize.xy;
  texture_coords.x = texture_coords.x+timer;
  float y = sin(texture_coords.x);
  vec3 colors = vec3(y);
  
  float pct = plot(texture_coords,y);
  colors = (1.0-pct)*colors+pct*vec3(0.0,1.0,0.0);
  
  return vec4(colors,1.0);
}

