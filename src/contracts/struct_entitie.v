module contracts

[flag]
pub enum JsonType {
	object
	array
	string
	number
	boolean
	null
}

pub struct KeyValueType {
pub:
	name string
	typ JsonType
	value ?[]KeyValueType
	parent ?&KeyValueType
}

pub fn (_ KeyValueType) builder_format(format Format) IGenerator {

}
