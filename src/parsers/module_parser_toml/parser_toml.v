module module_parser_toml

import entities { ObjStruct }
import contracts { IConfig, ObjType }
import toml
import helper

pub fn parser(object_toml_str string, conf IConfig) !ObjStruct {
	mut struct_obj_toml := ObjStruct{}

	obj_toml := toml.parse_text(object_toml_str)!.to_any()

	if obj_toml !is []toml.Any {
		struct_obj_toml.typ = .object | .root
		resolver_key_value(obj_toml, mut struct_obj_toml)
	} else {
		resolver_array(obj_toml, mut struct_obj_toml)
	}

	return struct_obj_toml
}

fn resolver_key_value(obj_toml toml.Any, mut struct_obj_json ObjStruct) {
	for key, value in obj_toml.as_map() {
		if value is []toml.Any {
			mut children := ObjStruct{
				name: key
				typ: .array
			}
			resolver_array(value, mut children)
			struct_obj_json.children << children
		} else if value is map[string]toml.Any {
			mut children := ObjStruct{
				name: key
				typ: .object
			}
			resolver_key_value(value, mut children)
			struct_obj_json.children << children
		} else {
			struct_obj_json.children << ObjStruct{
				name: key
				typ: resolver_type(value)
				value: resolver_value_type(value)
			}
		}
	}
}

fn resolver_array(obj_toml toml.Any, mut struct_obj_toml ObjStruct) {
	mut current_type := ObjType.array

	for item in obj_toml.array() {
		for key, value in item.as_map() {
			if value is []toml.Any {
				mut children := ObjStruct{
					name: key
					typ: .array
				}
				resolver_array(value, mut children)
				struct_obj_toml.children << children
			} else if value is map[string]toml.Any {
				mut children := ObjStruct{
					name: key
					typ: .object
				}
				resolver_key_value(value, mut children)
				struct_obj_toml.children << children
			} else {
				curr_item := resolver_type(value)
				current_type.set(curr_item)

				struct_obj_toml.children << ObjStruct{
					name: key
					typ: curr_item
					value: resolver_value_type(value)
				}
			}
		}
	}

	struct_obj_toml.typ = if helper.get_names_enum_setad(type_enum: current_type).len > 3 {
		ObjType.object | ObjType.array
	} else {
		current_type
	}
}

fn resolver_type(value toml.Any) ObjType {
	if value is bool {
		return .bool
	} else if value is f64 {
		return .number | .f32
	} else if value is i64 {
		return .number | .int
	} else if value is map[string]toml.Any {
		return .object
	} else if value is []toml.Any {
		return .array
	}
	return .string
}

fn resolver_value_type(value toml.Any) contracts.Any {
	return if value is bool {
		value
	} else if value is f64 {
		value
	} else if value is i64 {
		int(value)
	} else {
		value.string()
	}
}
