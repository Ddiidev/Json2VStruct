module scripts_gen

import x.json2

// Struct to be generated
struct Root {
	name string 
	age f32 
	@type string 
}


const json = r'
{
	"name": "André",
	"age": 25,
	"type": "is reservedword"
}
'

fn test_simple_keys() {
	mut obj_analyzed := json2.decode[Root](json)!

	assert obj_analyzed.name == "André"
	assert obj_analyzed.age == 25
	assert obj_analyzed.@type == "is reservedword"
}
