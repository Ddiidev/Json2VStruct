module genarator

import contracts { IConfig, IObjStruct }

pub fn build_struct(obj IObjStruct, conf IConfig) string {
	mut str_struct, deferred_struct := gen_struct(obj, conf)

	// println("\n############################################################################\n")
	// dump(deferred_struct)
	for this_deferred_struct in deferred_struct {
		temp_str_struct := build_struct(this_deferred_struct, conf)

		str_struct += '\n${temp_str_struct}'
	}

	// println("\n############################################################################\n")
	return str_struct
}

fn gen_struct(obj_struct IObjStruct, conf IConfig) (string, []IObjStruct) {
	mut obj := obj_struct
	mut struct_str := ''
	mut late_struct_implementation := []IObjStruct{}

	if obj.typ == .object | .root {
		struct_str = 'struct Root {\n'
		for i in 0 .. obj.children.len {
			child := obj.children[i]
			struct_str_temp, deferred_struct := gen_struct(child, conf)

			struct_str += struct_str_temp + '\n'
			late_struct_implementation << deferred_struct
		}
		struct_str += '}\n'
	} else if obj.typ == .object {
		name_property := obj.resolver_name_property(conf)
		attributes := name_property.construct_attribute(conf)

		if conf.struct_anon {
			obj.typ.set(.anonymous)
			struct_code := build_struct(obj, conf).replace('\n', '\n\t').trim_right('\n\t')
			struct_str += '\t${name_property.name} ${struct_code} ${attributes}'
		} else {
			struct_str += '\t${name_property.name} ${obj.resolver_name_type()} ${attributes}'
			obj.typ.set(.deferred)

			late_struct_implementation << obj
		}
	} else if obj.typ == .object | .deferred {
		struct_str = 'struct ${obj.resolver_name_type()} {\n'
		for i in 0 .. obj.children.len {
			child := obj.children[i]
			struct_str_temp, _ := gen_struct(child, conf)

			struct_str += struct_str_temp + '\n'
		}
		struct_str += '}\n'
		return struct_str, late_struct_implementation
	} else if obj.typ == .object | .anonymous {
		struct_str = 'struct {\n'
		for i in 0 .. obj.children.len {
			child := obj.children[i]
			struct_str_temp, _ := gen_struct(child, conf)

			struct_str += struct_str_temp + '\n'
		}
		struct_str += '}\n'
	} else if obj.typ == .object | .array {
		// mut struct_str_local := '\t${obj.name} []struct {\n'
		// for i in 0 .. obj.children.len {
		// 	child := obj.children[i]
		// 	struct_str_temp, deferred_struct := gen_struct(child, conf)
		//
		// 	struct_str_local += '\t${struct_str_temp}\n'
		// 	late_struct_implementation << deferred_struct
		// }
		// struct_str_local += '\t}\n'
	} else if obj.typ == .string {
		name_property := obj.resolver_name_property(conf)
		attributes := name_property.construct_attribute(conf)

		struct_str += '\t${name_property.name} string ${attributes}'
	} else if obj.typ == .number {
		name_property := obj.resolver_name_property(conf)
		attributes := name_property.construct_attribute(conf)

		struct_str += '\t${name_property.name} f32 ${attributes}'
	} else if obj.typ == .boolean {
		name_property := obj.resolver_name_property(conf)
		attributes := name_property.construct_attribute(conf)

		struct_str += '\t${name_property.name} bool ${attributes}'
	} else if obj.typ == .array {
		name_property := obj.resolver_name_property(conf)
		attributes := name_property.construct_attribute(conf)

		struct_str += '\t${name_property.name} []string ${attributes}'
	} else if obj.typ == .null {
		name_property := obj.resolver_name_property(conf)
		attributes := name_property.construct_attribute(conf)

		struct_str += '\t${name_property.name} ?string ${attributes}'
	}

	// println("\n>> @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@\n")
	// dump(obj)
	// println("\n-------------------------------------------------------------------------------\n")
	// dump(late_struct_implementation)
	// println("\n@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ <<\n")

	return struct_str, late_struct_implementation
}
