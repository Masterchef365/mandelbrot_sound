// Gold Noise ©2015 dcerisano@standard3d.com
// - based on the Golden Ratio
// - uniform normalized distribution
// - fastest static noise generator function (also runs at low precision)
// - use with indicated seeding method


const float PHI = 1.61803398874989484820459; // Φ = Golden Ratio 

float gold_noise(in vec2 xy, in float seed)
{
    return fract(tan(distance(xy*PHI, xy)*seed)*xy.x);
}

const int steps = 200;
int mandelbrot(vec2 st) {
    float a = st.x;
    float b = st.y;
    int finish = 0;

    for (int i = 0; i < steps; i++) {
        float tmp = a * a - b * b + st.x;
        //float tmp = b * b - a * a + st.x;
        b = 2. * a * b + st.y;
        a = tmp;
        if (a > 9e9 || b > 9e9) {
            finish = i;
            break;
        }
    }
    return finish;
}

vec2 begin = vec2(-1.46, 0.01);
vec2 end = vec2(-1.2, 0.2);

vec2 sample_pos(float time) {
    return mix(begin, end, fract(time * 31.));
}

float cross_mag(vec2 a, vec2 b) {
    return a.x * b.y - a.y * b.x;
}

bool near_line(vec2 st, float width) {
    vec2 u = st - end;
    vec2 v = begin - end;
    float proj = cross_mag(u, v) * dot(v, v);
    return proj < width;
}


bool near_end(vec2 st, float width) {
    return distance(st, begin) < width || distance(st, end) < width;
}


bool near_sample(vec2 st, float width, float time) {
    return distance(st, sample_pos(time)) < width;
}