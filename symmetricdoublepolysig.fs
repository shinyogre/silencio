extern mat4 scaler;


float doublePolySig (float x, float a, float b, int n) 
{
  float y = 0;
  if (mod(n,2) == 0) {
    //even polynomial
    if (x<=0.5){
      y = pow(2.0*x,n)/2.0;
    } else {
      y = 1.0 - pow(2*(x-1),n)/2;
    }    
  }
  
  else {
  //odd polynomial
  if(x <=0.5){
    y = pow(2.0*x,n)/2.0;
  } else {
    y = 1.0 + pow(2.0*(x-1),n)/2.0;
    }
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
  float y = doublePolySig(texture_coords.x,0.5,0.5,2);
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