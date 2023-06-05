module genarators

import contracts { IObjStruct }

pub struct GeneratorJson {
	obj IObjStruct
}

pub fn (gen GeneratorJson) execute() string {
	return gen_struct(gen.obj)
}

fn gen_struct(obj IObjStruct) string {
	mut struct_str := ''
	if obj.typ == .object | .root {
		struct_str = '{\n'
		for i in 0 .. obj.children.len {
			child := obj.children[i]
			struct_str += gen_struct(child)
			struct_str += if i < obj.children.len - 1 { ',\n' } else { '\n' }
		}
		struct_str += '}\n'
	} else if obj.typ == .string {
		struct_str += '\t"${obj.name}": "${obj.values.first().get()}"'
	} else if obj.typ in [.number, .boolean, .null] {
		struct_str += '\t"${obj.name}": ${obj.values.first().get()}'
	}
	return struct_str
}
