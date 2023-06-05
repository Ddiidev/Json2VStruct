module tests

import entities
import os

const json = r'
{
	"name": "André",
	"age": 25,
	"is_people": true,
	"height": 1.75
}
'

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

	str_json := obj_json.builder_struct()

	mut file := os.open_append('temp_simple_keys_test.v')!

	// writer struct
	file.write_string('import x.json2\n')!

	file.write_string(str_json)!

	file.write_string('\n\n')!
	file.write_string('const json = r\'${tests.json}\'\n')!

	file.write_string('fn test_temp_simple_keys() {\n')!

	file.write_string('\tmut obj_analyzed := json2.decode[Root](json)!\n')!
	file.write_string('\tassert obj_analyzed.name == "André"\n')!
	file.write_string('\tassert obj_analyzed.age == 25\n')!
	file.write_string('\tassert obj_analyzed.is_people == true\n')!
	file.write_string('\tassert obj_analyzed.height == 1.75\n')!

	file.write_string('\n}')!

	file.close()

	result := os.execute('v -stats test temp_simple_keys_test.v')

	os.rm('temp_simple_keys_test.v')!

	assert result.exit_code == 0, 'TEST_TMEMP_SIMPLE_KEYS FAILED: ${result.output}\nSTRUCT GEN: ${str_json}'
}
