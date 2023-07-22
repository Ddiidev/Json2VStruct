module genarator

import contracts { IConfig, IObjStruct }

fn call_recursive_root_object(mut obj IObjStruct, conf IConfig) !(string, []IObjStruct) {
	mut struct_str := 'struct Root {\n'
	mut late_struct_implementation := []IObjStruct{}

	for i in 0 .. obj.children.len {
		child := obj.children[i]
		str_from_struct, postponed_assemblies := gen_struct(child, conf)!

		struct_str += str_from_struct + '\n'
		late_struct_implementation << postponed_assemblies
	}
	struct_str += '}\n'

	return struct_str, late_struct_implementation
}

fn new_struct_deferred(mut obj IObjStruct, conf IConfig) !(string, []IObjStruct) {
	mut struct_str := 'struct ${obj.resolver_name_type()} {\n'
	mut late_struct_implementation := []IObjStruct{}

	for i in 0 .. obj.children.len {
		child := obj.children[i]
		temp_str_from_struct, temp_postponed_assemblies := gen_struct(child, conf)!
		late_struct_implementation << temp_postponed_assemblies
		struct_str += temp_str_from_struct + '\n'
	}
	struct_str += '}\n'

	return struct_str, late_struct_implementation
}

fn new_property_type_struct(mut obj IObjStruct, conf IConfig) !(string, []IObjStruct) {
	mut struct_str := ''
	mut late_struct_implementation := []IObjStruct{}
	property := obj.resolver_name_property(conf).resolver_attribute(conf)

	if conf.struct_anon {
		obj.assign_anonymous_object()
		struct_code := build_struct(obj, conf)!.replace('\n', '\n\t').trim_right('\n\t')
		struct_str += '\t${property.name} ${struct_code} ${property.attributes}'
		return struct_str, []IObjStruct{}
	} else {
		struct_str += '\t${property.name} ${obj.resolver_name_type()} ${property.attributes}'
		obj.assign_late_construction_object()
		late_struct_implementation << obj
		return struct_str, late_struct_implementation
	}
}
