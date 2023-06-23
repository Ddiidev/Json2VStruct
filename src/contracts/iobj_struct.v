module contracts

pub interface IObjStruct {
mut:
	name string
	typ ObjType
	children []IObjStruct
	value Any
	resolver_name_type() string
	resolver_name_property(conf IConfig) INameKey
}
