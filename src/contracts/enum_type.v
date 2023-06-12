module contracts

[flag]
pub enum ObjType {
	object
	root
	array
	string
	number
	boolean
	null
	// type of control
	anonymous
	deferred
}
