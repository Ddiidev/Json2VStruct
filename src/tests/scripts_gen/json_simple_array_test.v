module scripts_gen

import json

// Struct to be generated
struct Root {
	childrens_str  []string
	childrens_int  []int
	childrens_f32  []f32
	childrens_bool []bool
}

const json = r'
{
	"childrens_str": ["André", "Milca", "Dante"],
	"childrens_int": [0,1,2],
	"childrens_f32": [0.1,1.1,2.1],
	"childrens_bool": [true, false, true]
}
'

fn test_simple_keys() {
	mut obj_analyzed := json.decode(Root, scripts_gen.json)!

	assert obj_analyzed.childrens_int.len == 3
	assert obj_analyzed.childrens_f32.len == 3
	assert obj_analyzed.childrens_str.len == 3
	assert obj_analyzed.childrens_bool.len == 3

	assert obj_analyzed.childrens_int[0] == 0
	assert obj_analyzed.childrens_f32[0] == 0.1
	assert obj_analyzed.childrens_str[0] == 'André'
	assert obj_analyzed.childrens_bool[0] == true
}
