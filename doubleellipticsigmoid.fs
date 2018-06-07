extern mat4 scaler;
extern vec2 mouse;


float doubleEllipticSigmoid(float x, float a, float b)
{
  float epsilon = 0.00001;
  float min_param_a = 0.0 + epsilon;
  float max_param_a = 1.0 - epsilon;
  float min_param_b = 0.0;
  float max_param_b = 1.0;
  a = max(min_param_a,min(max_param_a,a));
  b = max(min_param_a,min(max_param_b,b));
  
  float y = 0;
  if (x<=a) {
    y = b * (1-(sqrt(a*a) - (x*x)/a));
  } else {
    y = b + ((1-b)/(1-a))*sqrt(((1-a)*(1-a))-(x-1)*(x-1));
  }
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
  float y = doubleEllipticSigmoid(texture_coords.x,0.2,0.5);
  
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