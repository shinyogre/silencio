extern mat4 scaler;
extern vec2 mouse;

// Joining Two Lines with a Circular Arc Fillet
// Adapted from Robert D. Miller / Graphics Gems III.

float arcStartAngle;
float arcEndAngle;
float arcStartX, arcStartY;
float arcEndX, arcEndY;
float arcCenterX, arcCenterY;
float arcRadius;

float circularFillet(float x, float a, float b, float R)
{

  

}



float plot (vec2 texture_coords, float pct)
{
  return smoothstep(pct-0.02, pct, texture_coords.y) - smoothstep(pct, pct+0.02, texture_coords.y);
}



#ifdef PIXEL
vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords )
{
  texture_coords = (screen_coords/love_ScreenSize.xy);
  float y = circularFillet(texture_coords.x,0.2,0.8, 0.2);
  
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