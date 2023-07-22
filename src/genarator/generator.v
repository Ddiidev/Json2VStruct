module genarator

import contracts { IConfig, IObjStruct }

pub fn build_struct(obj IObjStruct, conf IConfig) !string {
	// dump(obj)
	// return ''
	mut str_from_struct, postponed_assemblies := gen_struct(obj, conf)!

	for current_deferred_assembly in postponed_assemblies {
		temp_str_from_struct := build_struct(current_deferred_assembly, conf)!
		str_from_struct += '\n${temp_str_from_struct}'
	}

	return str_from_struct
}

fn gen_struct(obj_struct IObjStruct, conf IConfig) !(string, []IObjStruct) {
	mut obj := obj_struct
	mut late_struct_implementation := []IObjStruct{}
	mut struct_str := ''

	if obj.this_item_is_root_object() {
		//
		temp_struct_str, temp_late_struct_implementation := call_recursive_root_object(mut obj,
			conf)!

		struct_str += temp_struct_str
		late_struct_implementation << temp_late_struct_implementation
	} else if obj.this_item_is_object_without_definition() {
		//
		temp_struct_str, temp_late_struct_implementation := new_property_type_struct(mut obj,
			conf)!

		struct_str += temp_struct_str
		late_struct_implementation << temp_late_struct_implementation
	} else if obj.typ == .object | .deferred {
		//
		temp_struct_str, temp_preponed_assemblies := new_struct_deferred(mut obj, conf)!

		struct_str += temp_struct_str
		late_struct_implementation << temp_preponed_assemblies
	} else if obj.this_item_is_object_ononymous() {
		//
		struct_str += new_property_struct_anonymous(mut obj, conf)!
	} else if obj.this_is_object_array() {
		//
		temp_struct_str, temp_preponed_assemblies := new_property_object(mut obj, conf)!

		struct_str += temp_struct_str
		late_struct_implementation << temp_preponed_assemblies
	} else if obj.this_item_is_array() {
		//
		struct_str += new_property_array(mut obj, conf)
	} else if obj.this_item_is_string() {
		//
		property := obj.resolver_name_property(conf).resolver_attribute(conf)

		struct_str += '\t${property.name} string ${property.attributes}'
	} else if obj.this_item_is_number() {
		//
		struct_str += new_property_number(mut obj, conf)!
	} else if obj.this_item_is_bool() {
		//
		struct_str += new_property_bool(mut obj, conf)
	} else if obj.this_item_is_any_array() {
		//
		struct_str += new_property_any_array(mut obj, conf)
	} else if obj.this_item_is_null() {
		//
		struct_str += new_property_null(mut obj, conf)
	}

	return struct_str, late_struct_implementation
}
