extern mat4 scaler;
extern vec2 mouse;

float quadraticBezier (float x, float a, float b) {
  // adapted from BEZMATH.PS (1993)
  // by Don Lancaster, SYNERGETICS Inc. 
  // http://www.tinaja.com/text/bezmath.html
  
  float epsilon = 0.00001;
  a = max(0,min(1,a));
  b = max(0,min(1,b));
  if (a == 0.5) {
    a = a + epsilon;
  }
  
  //solve t from x (an inverse operation)
  float om2a = 1 - 2*a;
  float t = (sqrt(a*a + om2a*x) - a)/om2a;
  float y = (1-2*b)*(t*t) + (2*b)*t;
  return y;
  
}
  

float plot (vec2 texture_coords, float pct)
{
  return smoothstep(pct-0.02, pct, texture_coords.y) - smoothstep(pct, pct+0.02, texture_coords.y);
}



#ifdef PIXEL
vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords )
{
  texture_coords = (screen_coords/love_ScreenSize.xy);
  float y = quadraticBezier(texture_coords.x, mouse.x, 0.4);
  
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