module scripts_gen

import toml

// Struct to be generated
struct Root {
	my_name string [toml: 'my name']
	nums    []int
}

const str_object = r'
		"my name" = "André"
		nums = [0,1,2]
	'

fn test_simple_keys() {
	mut obj_analyzed := toml.parse_text(scripts_gen.str_object)!.reflect[Root]()

	assert obj_analyzed.my_name == 'André'
	assert obj_analyzed.nums.len == 3
}
