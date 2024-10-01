shader_type canvas_item;

uniform vec4 color = vec4(1.0, 1.0, 1.0, 1.0); // Cor e alpha
uniform float amplitude = 0.1;
uniform float speed = 1.0;
uniform float radius = 0.5; // Raio do círculo

void fragment() {
    vec2 uv = UV;
    float dist = distance(uv, vec2(0.5));

    // Calcular alpha baseado na distância do centro
    float alpha = smoothstep(radius + 0.01, radius, dist);

    // Cálculo da onda
    float wave = sin(dist * 20.0 + TIME * speed);

    // Aplicando a onda à coordenada UV
    uv.x += wave * amplitude * uv.x;
    uv.y += wave * amplitude * uv.y;

    COLOR = texture(TEXTURE, uv) * color * alpha;
}