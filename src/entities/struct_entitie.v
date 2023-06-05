module entities

import contracts { Any, IObjStruct, ObjType }
import genarator { gen_struct }

pub struct ObjStruct {
pub mut:
	name     string
	typ      ObjType
	children []IObjStruct
	values   []Any
	parent   ?&IObjStruct
}

pub fn (this ObjStruct) builder_struct() string {
	return gen_struct(this)
}
