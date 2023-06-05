module entities

import contracts { Any, Format, IGenerator, IObjStruct, ObjType }
import genarators.formater

pub struct ObjStruct {
pub mut:
	name     string
	typ      ObjType
	children []IObjStruct
	values   []Any
	parent   ?&IObjStruct
}

pub fn (this ObjStruct) builder_format(format Format) IGenerator {
	return formater.new(this, format)
}
