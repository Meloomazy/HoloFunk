#pragma header
uniform float pixelly;
void main()
{
    vec2 uv = openfl_TextureCoordv*openfl_TextureSize/openfl_TextureSize.xy;
    uv = floor(uv*openfl_TextureSize.x*pixelly)/(openfl_TextureSize.x*pixelly);
    gl_FragColor = flixel_texture2D(bitmap, uv);
}