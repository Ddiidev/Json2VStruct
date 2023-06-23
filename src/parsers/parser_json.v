module parsers

import entities { Config, ObjStruct }
import x.json2
import contracts { ObjType }

fn parser_json(object_json_str string, conf Config) !string {
	mut struct_obj_json := ObjStruct{}

	obj_json := json2.raw_decode(object_json_str) or { return err }

	if obj_json !is []json2.Any {
		struct_obj_json.typ = .object | .root
		resolver_key_value(obj_json, mut struct_obj_json)
	} else {
		resolver_array(obj_json, mut struct_obj_json)
	}

	dump(struct_obj_json)
	return '' // struct_obj_json.builder_struct(conf)
}

fn resolver_key_value(obj_json json2.Any, mut struct_obj_json ObjStruct) {
	for key, value in obj_json.as_map() {
		if value is []json2.Any {
			mut children := ObjStruct{
				typ: .array
			}
			resolver_array(value, mut children)
			struct_obj_json.children << children
		} else {
			struct_obj_json.children << ObjStruct{
				name: key
				typ: resolver_type(value)
				value: contracts.Any(value.str())
			}
		}
	}
}

fn resolver_array(obj_json json2.Any, mut struct_obj_json ObjStruct) {
	current_type := ObjType.array

	for item in obj_json.arr() {
		for key, value in item.as_map() {
			if value is []json2.Any {
				mut children := ObjStruct{
					typ: .array
				}
				resolver_array(value, mut children)
				struct_obj_json.children << children
			} else if value is map[string]json2.Any {
				mut children := ObjStruct{
					typ: .object
				}
				resolver_key_value(value, mut children)
				struct_obj_json.children << children
			} else {
				struct_obj_json.children << ObjStruct{
					name: key
					typ: resolver_type(value)
					value: contracts.Any(value.str())
				}
			}
		}
	}
}

fn resolver_type(value json2.Any) ObjType {
	return .string
}
