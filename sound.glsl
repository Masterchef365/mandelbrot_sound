vec2 mainSound( int samp, float time )
{
    // A 440 Hz wave that attenuates quickly overt time
    float t = fract(time / 1.);
    
    int m = mandelbrot(sample_pos(t));
    
    float mf = float(m) / float(steps);
    
    float s = mf;//cos(t * 700.);
    
    return vec2(clamp(s, 0., 1.) * 0.9);
}