#ifdef GL_ES
precision mediump number;
#endif

extern number time;

vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords )
{
  return vec4(abs(sin(time)),0.0,0.0,1.0);
}

