extern mat4 scaler;


// Blinn-Wyvill Cosine Approximations
// http://www.flong.com/texts/code/shapers_poly/  


float doubleCubicSeat (float x, float a, float b) 
{
  float epsilon = 0.00001;
  float min_param_a = 0.0 + epsilon;
  float max_param_a = 1.0 - epsilon;
  float min_param_b = 0.0;
  float max_param_b = 1.0;
  a = min(max_param_a, max(min_param_a,a));
  b = min(max_param_b, max(min_param_b,b));
  
  float y = 0;
  if (x <= a) {
    y = b-b*pow(1-x/a,3.0);
  } else {
    y = b + (1-b)*pow((x-a)/(1-a),3.0);
  }
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
  float y = doubleCubicSeat(texture_coords.x,0.6,0.25);
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