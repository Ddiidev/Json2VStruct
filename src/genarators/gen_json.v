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
		struct_str = 'struct Root {\n'
		for i in 0 .. obj.children.len {
			child := obj.children[i]
			struct_str += gen_struct(child) + '\n'
		}
		struct_str += '}\n'
	} else if obj.typ == .string {
		struct_str += '\t${obj.name} string'
	} else if obj.typ == .number {
		struct_str += '\t${obj.name} f32'
	} else if obj.typ == .boolean {
		struct_str += '\t${obj.name} bool'
	} else if obj.typ == .array {
		struct_str += '\t${obj.name} []'
	} else if obj.typ == .null {
		struct_str += '\t${obj.name} ?Any'
	}
	return struct_str
}
