#ifndef GRID_INCLUDED
#define GRID_INCLUDED

void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
{
    Out = UV * Tiling + Offset;
}

void Grid_float(float2 x_grid, float2 UV, float time, float2 offset, out float2 Out)
{   
    float4 col = 0;
   
    float2 aspect = float2(2, 1);

    float2 tiling = x_grid * aspect;

  //  float2 offset = float2(0, 0);

    float2 uv = x_grid * aspect;

    Unity_TilingAndOffset_float(UV, tiling, offset, uv);

   

    uv.y += time * 0.25;

    float2 gv = frac(uv) - 0.5;

    Out = gv;
    
}   

void GridOutline_float(float2 gv, out float4 Out) 
{
    float4 col = 0;

    if (gv.x > 0.47 || gv.y > 0.48) col = float4(1, 0, 0, 1);

    Out = col;
}

void time_float(float time_offset, float time_mult, out float Out)
{
    float t = _Time.y;

    Out = (t*time_mult) + time_offset;
}

void X_float(float n, float2 uv, out float Out)
{
    float w = uv.y * 10;
    float x = (n - 0.5) * 0.8; // -.4 to .4 in x
        x += (0.4 - abs(x)) * sin(3 * w) * pow(sin(w), 6) * 0.75;
    Out = x;
}

void Y_float(float t, out float Out)
{
    Out = -sin(t + sin(t + sin(t) * 0.5)) * 0.45;
}

void finalXY_float(float2 gvOut, float x, float y, out float xOut, out float yOut)
{
    float yVar = y;
    yVar -= pow((gvOut.x - x), 2);
    xOut = x;
    yOut = yVar;
}
void DropPos_float(float x, float y, float2 aspect, float2 gvOut, out float2 Out)
{
    Out = (gvOut - float2(x, y) )/ aspect;
}

void TrailPos_float(float x, float y, float2 aspect, float2 gvOut, out float2 Out)
{
    float2 trailPos = (gvOut - float2(x, y)) / aspect;
    trailPos.y = (frac(trailPos.y * 8) - 0.5) / 8;
    Out = smoothstep(0.03, 0.01, length(trailPos));
}

void trail_float(float2 trailPos, float2 dropPos, float2 gv, float y, out float Out)
{
    float trail = trailPos * smoothstep(-0.05, 0.05, dropPos.y);
    
 
    trail *= smoothstep(0.5, y, gv.y);
  
    Out = trail;
}

void fogTrail_float(float2 dropPos, float trail, float2 gv, float y, out float fogTrailOut, out float trailOut)
{
    float fogTrail = smoothstep(-0.05, 0.05, dropPos.y);
    fogTrail *= smoothstep(0.5, y, gv.y);

    trail *= fogTrail;
    fogTrail *= smoothstep(.05, .04, abs(dropPos.x));
    fogTrailOut = fogTrail * 0.5;
    trailOut = trail;
}

void idCol_float(float2 id, out float2 Out)
{
    float4 col = 0;
    col.rg = id * 0.1;
    Out = col.rg;
}

void N21_float(float2 p, out float Out)
{
    p = frac(p * float2(123.34, 345.45));
    p += dot(p, p + 34.345);
    Out = p;
}

void finalResult_float(float2 uv, float2 dropPos, float2 drop, float2 trailPos, float2 trail, float2 distortion, out float2 Out)
{
    float2 offs = drop * dropPos + trail * trailPos;

    Out = uv + offs * distortion;
}
#endif // GRID_INCLUDED