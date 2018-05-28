extern mat4 scaler;
extern vec2 mouse;

float logisticalSigmoid (float x, float a) 
{
  // n.b.: this Logistic Sigmoid has been normalized.
  
  float epsilon = 0.0001;
  float min_param_a = 0.0 + epsilon;
  float max_param_a = 1.0 - epsilon;
  a = max(min_param_a,min(max_param_a,a));
  a = (1/(1-a) - 1);
  
  float A = 1.0/(1.0 + exp(0 -((x-0.5)*a*2.0)));
  float B = 1.0/(1.0 + exp(a));
  float C = 1.0/(1.0 + exp(0-a));
  float y = (A-B)/(C-B);
  
  return y;

}



float plot(vec2 texture_coords, float pct)
{
  return smoothstep(pct-0.02, pct, texture_coords.y) - smoothstep(pct, pct+0.02, texture_coords.y);
}



#ifdef PIXEL
vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords )
{
  texture_coords = (screen_coords/love_ScreenSize.xy);
  float y = logisticalSigmoid(texture_coords.x,mouse.x);
  
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