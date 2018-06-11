#ifdef GL_ES
precision mediump number;
#endif
#define PI 3.14159265359

extern mat4 scaler;
extern vec2 mouse;
 

float plot (vec2 texture_coords, float pct)
{
  return smoothstep(pct-0.02, pct, texture_coords.y) - smoothstep(pct, pct+0.02, texture_coords.y);
}



#ifdef PIXEL
vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords )
{
  texture_coords = (screen_coords/love_ScreenSize.xy);
  texture_coords.x *= 10;
  //texture_coords.x += 0.5;
  texture_coords.y = 1.0 - texture_coords.y;
  texture_coords.y -= 0.5;
  texture_coords.y *= 10;
  //float y = 1.0 - pow(abs(texture_coords.x),0.5);
  //float y = 1.0 - pow(abs(texture_coords.x),3.5);
  //float y = pow(cos(PI*texture_coords.x/2.0),1.5);
  //float y = 1.0 - pow(abs(sin(PI * texture_coords.x/2.0)),0.5);
  //float y = pow(min(cos(PI*texture_coords.x/2.0),1.0 - abs(texture_coords.x)),2.5);
  //float y = 1.0-pow(max(0.0,abs(texture_coords.x)*2.0-1.0),0.5);
  //float y = -sin(5*texture_coords.x)/texture_coords.x;
  float y = floor(texture_coords.x);
  vec3 colors = vec3(y);
  float pct = plot(texture_coords,y);
  colors = (1.0-pct)*colors+pct*vec3(0.0,1.0,0.0);
  
  return vec4(colors,1);
}  
#endif



#ifdef VERTEX 
vec4 position( mat4 transform_projection, vec4 vertex_position )
{
  return scaler * transform_projection * vertex_position;
}
#endif