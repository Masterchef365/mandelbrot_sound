vec3 fractal(vec2);
void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 st = (fragCoord/iResolution.xy) * 2. - 1.;
    st.x *= iResolution.x/iResolution.y;
    const float scale = pow(0.5, 2.);
    st *= scale;
 	st -= vec2(1.413, 0);
    
    vec3 col = fractal(st);
    if (near_end(st, 0.01)) col = vec3(0., 1., 0.);
    if (near_sample(st, 0.01, iTime)) col = vec3(0., 0.7, 1.);

    // Output to screen
    fragColor = vec4(col,1.0);
}

const float pi = 3.141592;
const float tau = 2. * pi;

vec3 fractal(vec2 st) {
    int finish = mandelbrot(st);
    
    if (finish == 0) return vec3(0);
    
    float g = float(finish) / float(steps);
    g = pow(g, .5);
    g = cos(g * tau * 3.);
    
    vec3 color = mix(
        mix(vec3(0.840,0.056,0.461), vec3(0.785,0.157,0.082) * 2., g),
        mix(vec3(1.000,0.886,0.491) * -0.880, vec3(0.179,0.022,0.530), g),
        g
    );


    return color;
}