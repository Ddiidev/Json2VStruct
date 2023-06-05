module tests

import x.json2
import entities

struct Be {
	name      string
	age       int
	is_people bool
	height    f32
}

fn test_simple_keys() {
	mut obj_json := entities.ObjStruct{
		name: ''
		typ: .object | .root
		children: [
			entities.ObjStruct{
				name: 'name'
				typ: .string
				values: ['André']
			},
			entities.ObjStruct{
				name: 'age'
				typ: .number
				values: [25]
			},
			entities.ObjStruct{
				name: 'is_people'
				typ: .boolean
				values: [true]
			},
			entities.ObjStruct{
				name: 'height'
				typ: .number
				values: [1.75]
			},
		]
	}

	str_json := obj_json.builder_format(.json).execute()

	obj_analyzed := json2.decode[Be](str_json)!

	assert obj_analyzed.name == 'André'
	assert obj_analyzed.age == 25
	assert obj_analyzed.is_people == true
	assert obj_analyzed.height == 1.75
}
