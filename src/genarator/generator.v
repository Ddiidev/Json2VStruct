module genarator

import contracts { IConfig, IObjStruct }
import helper

pub fn build_struct(obj IObjStruct, conf IConfig) !string {
	mut str_struct, deferred_struct := gen_struct(obj, conf)!

	for this_deferred_struct in deferred_struct {
		temp_str_struct := build_struct(this_deferred_struct, conf)!
		str_struct += '\n${temp_str_struct}'
	}

	return str_struct
}

fn gen_struct(obj_struct IObjStruct, conf IConfig) !(string, []IObjStruct) {
	mut obj := obj_struct
	mut late_struct_implementation := []IObjStruct{}
	mut struct_str := ''

	if obj.typ == .object | .root {
		struct_str = 'struct Root {\n'
		for i in 0 .. obj.children.len {
			child := obj.children[i]
			struct_str_temp, deferred_struct := gen_struct(child, conf)!

			struct_str += struct_str_temp + '\n'
			late_struct_implementation << deferred_struct
		}
		struct_str += '}\n'
	} else if obj.typ == .object {
		name_property := obj.resolver_name_property(conf)
		attributes := name_property.construct_attribute(conf)

		if conf.struct_anon {
			obj.typ.set(.anonymous)
			struct_code := build_struct(obj, conf)!.replace('\n', '\n\t').trim_right('\n\t')
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
			struct_str_temp, temp_late_struct_implementation := gen_struct(child, conf)!
			late_struct_implementation << temp_late_struct_implementation
			struct_str += struct_str_temp + '\n'
		}
		struct_str += '}\n'

		return struct_str, late_struct_implementation
	} else if obj.typ == .object | .anonymous {
		struct_str = 'struct {\n'
		for i in 0 .. obj.children.len {
			child := obj.children[i]
			struct_str_temp, _ := gen_struct(child, conf)!

			struct_str += struct_str_temp + '\n'
		}
		struct_str += '}\n'
	} else if obj.typ == .object | .array {
		obj.typ = .object
		if conf.struct_anon {
			obj.typ.set(.anonymous)
		}
		temp_struct_str, defer_code := gen_struct(obj, conf)!

		type_name_or_struct := if conf.struct_anon {
			temp_struct_str.replace('\n', '\n\t').trim_right('\n\t')
		} else {
			obj.resolver_name_type()
		}

		name_property := obj.resolver_name_property(conf)
		attributes := name_property.construct_attribute(conf)
		struct_str += '\t${name_property.name} []${type_name_or_struct} ${attributes}'

		late_struct_implementation << defer_code
	} else if obj.typ.has(.array) && obj.typ.has(.string | .number | .bool) {
		name_property := obj.resolver_name_property(conf)
		attributes := name_property.construct_attribute(conf)

		name_type := helper.get_names_enum_setad[contracts.ObjType](
			type_enum: obj.typ
		).filter(it !in ['array', 'number'])[0]

		struct_str += '\t${name_property.name} []${name_type} ${attributes}'
	} else if obj.typ == .string {
		name_property := obj.resolver_name_property(conf)
		attributes := name_property.construct_attribute(conf)

		struct_str += '\t${name_property.name} string ${attributes}'
	} else if obj.typ.has(.number) {
		name_property := obj.resolver_name_property(conf)
		attributes := name_property.construct_attribute(conf)

		name_type := helper.get_names_enum_setad[contracts.ObjType](
			type_enum: obj.typ
		).filter(it != 'number')[0] or { return error('not found type number. "${name_property.name}" is of numeric type -> ${obj.typ} <-') }

		struct_str += '\t${name_property.name} ${name_type} ${attributes}'
	} else if obj.typ == .bool {
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

	return struct_str, late_struct_implementation
}
