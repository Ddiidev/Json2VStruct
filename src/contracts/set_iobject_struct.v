module contracts

pub fn (mut this IObjStruct) assign_anonymous_object() {
	this.typ.set(.anonymous)
}

pub fn (mut this IObjStruct) assign_late_construction_object() {
	this.typ.set(.deferred)
}
