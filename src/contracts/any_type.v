module contracts

import time { Time }

pub struct Null {}

pub type Any = Null | Time | []Any | bool | f32 | f64 | i64 | int | map[string]Any | string | u64

pub fn (t Any) get() string {
	return if t is string {
		t.str()
	} else if t is int {
		t.str()
	} else if t is u64 {
		t.str()
	} else if t is i64 {
		t.str()
	} else if t is f32 {
		t.str()
	} else if t is f64 {
		t.str()
	} else if t is bool {
		t.str()
	} else if t is Time {
		t.str()
	} else if t is []Any {
		'not implemented'
	} else if t is map[string]Any {
		'not implemented'
	} else {
		'null'
	}
}
