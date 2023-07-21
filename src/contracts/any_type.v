module contracts

import time { Time }
pub struct Null {}

pub type Any = Null | Time | []Any | bool | f32 | f64 | i64 | int | map[string]Any | string | u64
