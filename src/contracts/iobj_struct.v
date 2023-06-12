module contracts

pub interface IObjStruct {
mut:
	name string
	typ ObjType
	children []IObjStruct
	values []Any
	parent ?&IObjStruct
	resolver_name_type() string
	resolver_name_property() NameKey
}
