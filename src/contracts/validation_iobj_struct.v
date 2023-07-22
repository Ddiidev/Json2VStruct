module contracts

pub fn (this IObjStruct) this_item_is_root_object() bool {
	return this.typ == .object | .root
}

pub fn (this IObjStruct) this_item_is_object_without_definition() bool {
	return this.typ == .object
}

pub fn (this IObjStruct) this_item_is_null() bool {
	return this.typ == .null
}

pub fn (this IObjStruct) this_item_is_any_array() bool {
	return this.typ == .array
}

pub fn (this IObjStruct) this_item_is_bool() bool {
	return this.typ == .bool
}

pub fn (this IObjStruct) this_item_is_number() bool {
	return this.typ.has(.number)
}

pub fn (this IObjStruct) this_item_is_string() bool {
	return this.typ == .string
}

pub fn (this IObjStruct) this_item_is_array() bool {
	return this.typ.has(.array) && this.typ.has(.string | .number | .bool)
}

pub fn (this IObjStruct) this_is_object_array() bool {
	return this.typ == .object | .array
}

pub fn (this IObjStruct) this_item_is_object_ononymous() bool {
	return this.typ == .object | .anonymous
}
