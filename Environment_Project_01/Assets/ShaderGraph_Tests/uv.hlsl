#ifndef UV_INCLUDED
#define UV_INCLUDED

void uv_float(float gridSize, float2 aspect, out float2 Out)
{
	Out = gridSize * aspect;
}


#endif // UV_INCLUDED