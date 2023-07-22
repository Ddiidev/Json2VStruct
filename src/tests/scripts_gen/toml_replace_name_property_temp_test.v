module scripts_gen

import toml
// Struct to be generated
struct Root {
	my_name string [toml: "my name"]
	my_age int [toml: "my age"]
}


const str_object = r'
	"my name" = "André"
	"my age" = 25
	'

fn test_simple_keys() {
	mut obj_analyzed := toml.parse_text(str_object)!.reflect[Root]()

	assert obj_analyzed.my_name == "André"
	assert obj_analyzed.my_age == 25
}
