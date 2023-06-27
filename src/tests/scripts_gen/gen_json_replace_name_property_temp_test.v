module scripts_gen

import json

// Struct to be generated
struct Root {
	my_name string [json: 'my name']
	my_age  int    [json: 'my age']
}

const json = r'
{
	"my name": "André",
	"my age": 25
}
'

fn test_simple_keys() {
	mut obj_analyzed := json.decode(Root, scripts_gen.json)!

	assert obj_analyzed.my_name == 'André'
	assert obj_analyzed.my_age == 25
}
