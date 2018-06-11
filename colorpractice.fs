#ifdef GL_ES
precision mediump number;
#endif
#define PI 3.14159265359

extern mat4 scaler;
extern vec2 mouse;
extern float motion;

/*
vector[0] = vector.r = vector.x = vector.s;
vectorfloatvector.g = vector.y = vector.t;
vector[2] = vector.b = vector.z = vector.p;
vector[3] = vector.a = vector.w = vector.q;
*/
//Normalize N color value between 0 and 255: N*(1/255)

vec3 colorA = vec3(0.149,0.141,0.912);
vec3 colorB = vec3(1.000,0.833,0.224);

float shaping(float t) {
  return 1.0-pow(min(cos(PI*t/2.0),1.0-abs(t)),2.5);
}

float plot (vec2 texture_coords, float pct)
{
  return smoothstep(pct-0.01, pct, texture_coords.y) - smoothstep(pct, pct+0.01, texture_coords.y);
}

#ifdef PIXEL
vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords )
{
  texture_coords = (screen_coords/love_ScreenSize.xy);
  //texture_coords.x *= 10;
  //texture_coords.x = 0.5;
  //texture_coords.y = 1.0 - texture_coords.y;
  //texture_coords.y -= 0.5;
  //texture_coords.y *= 10;

  vec3 colors = vec3(0.0);
  vec3 pct = vec3(texture_coords.x);
    pct.r = smoothstep(0.0,1,texture_coords.x);
    pct.g = sin(texture_coords.x*PI);
    pct.b = pow(texture_coords.x,0.5);
    
  colors = mix(colorA,colorB,pct);
  
  colors = mix(colors,vec3(1.0,0.0,0.0),plot(texture_coords,pct.r));
  colors = mix(colors,vec3(0.0,1.0,0.0),plot(texture_coords,pct.g));
  colors = mix(colors,vec3(0.0,0.0,1.0),plot(texture_coords,pct.b));
  
  
  return vec4(colors,1);
}  
#endif



#ifdef VERTEX 
vec4 position( mat4 transform_projection, vec4 vertex_position )
{
  return scaler * transform_projection * vertex_position;
}
#endif