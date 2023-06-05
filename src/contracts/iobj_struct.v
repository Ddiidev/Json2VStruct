module contracts

pub interface IObjStruct {
mut:
	name string
	typ ObjType
	children []IObjStruct
	values []Any
	parent ?&IObjStruct
}
