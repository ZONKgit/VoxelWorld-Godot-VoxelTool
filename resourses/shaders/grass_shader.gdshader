shader_type spatial;



void vertex() {
// Input:2
	vec3 n_out2p0 = VERTEX;


// VectorDecompose:4
	float n_out4p0 = n_out2p0.x;
	float n_out4p1 = n_out2p0.y;
	float n_out4p2 = n_out2p0.z;


// Input:8
	float n_out8p0 = TIME;


// FloatOp:11
	float n_in11p1 = 0.20000;
	float n_out11p0 = n_out8p0 * n_in11p1;


// FloatFunc:10
	float n_out10p0 = sin(n_out11p0);


// FloatOp:15
	float n_in15p1 = 0.10000;
	float n_out15p0 = n_out10p0 * n_in15p1;


// FloatOp:16
	float n_out16p0 = n_out15p0 * n_out4p1;


// FloatOp:5
	float n_out5p0 = n_out4p0 + n_out16p0;


// VectorCompose:7
	vec3 n_out7p0 = vec3(n_out5p0, n_out4p1, n_out4p2);


// Output:0
	VERTEX = n_out7p0;


}

void fragment() {
// ColorConstant:2
	vec4 n_out2p0 = vec4(0.064091, 0.684903, 0.247474, 1.000000);


// Output:0
	ALBEDO = vec3(n_out2p0.xyz);


}