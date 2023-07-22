module genarator

import contracts { IConfig, IObjStruct }
import helper

fn new_property_struct_anonymous(mut obj IObjStruct, conf IConfig) !string {
	mut struct_str := 'struct {\n'
	for i in 0 .. obj.children.len {
		child := obj.children[i]
		temp_str_from_struct, _ := gen_struct(child, conf)!

		struct_str += '${temp_str_from_struct}\n'
	}
	struct_str += '}\n'
	return struct_str
}

fn new_property_null(mut obj IObjStruct, conf IConfig) string {
	property := obj.resolver_name_property(conf).resolver_attribute(conf)

	return '\t${property.name} ?string ${property.attributes}'
}

fn new_property_any_array(mut obj IObjStruct, conf IConfig) string {
	property := obj.resolver_name_property(conf).resolver_attribute(conf)

	return '\t${property.name} []string ${property.attributes}'
}

fn new_property_bool(mut obj IObjStruct, conf IConfig) string {
	property := obj.resolver_name_property(conf).resolver_attribute(conf)

	return '\t${property.name} bool ${property.attributes}'
}

fn new_property_number(mut obj IObjStruct, conf IConfig) !string {
	property := obj.resolver_name_property(conf).resolver_attribute(conf)

	name_type := helper.get_names_enum_setad[contracts.ObjType](
		type_enum: obj.typ
	).filter(it != 'number')[0] or {
		return error('not found type number. "${property.name}" is of numeric type -> ${obj.typ} <-')
	}

	return '\t${property.name} ${name_type} ${property.attributes}'
}

fn new_property_array(mut obj IObjStruct, conf IConfig) string {
	property := obj.resolver_name_property(conf).resolver_attribute(conf)

	name_type := helper.get_names_enum_setad[contracts.ObjType](
		type_enum: obj.typ
	).filter(it !in ['array', 'number'])[0]

	return '\t${property.name} []${name_type} ${property.attributes}'
}

fn new_property_object(mut obj IObjStruct, conf IConfig) !(string, []IObjStruct) {
	obj.typ = .object
	if conf.struct_anon {
		obj.typ.set(.anonymous)
	}
	temp_str_from_struct, postponed_assemblies := gen_struct(obj, conf)!

	type_name_or_struct := if conf.struct_anon {
		temp_str_from_struct.replace('\n', '\n\t').trim_right('\n\t')
	} else {
		obj.resolver_name_type()
	}

	property := obj.resolver_name_property(conf).resolver_attribute(conf)
	return '\t${property.name} []${type_name_or_struct} ${property.attributes}', postponed_assemblies
}
