module contracts

[flag]
pub enum ObjType {
	object
	root
	array
	string
	number
	int
	f32
	bool
	null
	// type of control
	anonymous
	deferred
}
