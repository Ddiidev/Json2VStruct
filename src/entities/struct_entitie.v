module entities

import contracts { Any, IObjStruct, ObjType }

pub struct ObjStruct {
pub mut:
	name     string
	typ      ObjType
	children []IObjStruct
	value    Any
}
