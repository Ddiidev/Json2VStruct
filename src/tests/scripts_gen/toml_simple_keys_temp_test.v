module scripts_gen

import toml

// Struct to be generated
struct Root {
	name string 
	age int 
	is_people bool 
	height f32 
}


const str_object = r'
	name = "André"
	age = 25
	is_people = true
	height = 1.75
	'

fn test_simple_keys() {
    mut obj_analyzed := toml.parse_text(str_object)!.reflect[Root]()

	assert obj_analyzed.name == "André"
	assert obj_analyzed.age == 25
	assert obj_analyzed.is_people == true
	assert obj_analyzed.height == 1.75
}
