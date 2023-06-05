module formater

import contracts { Format, IGenerator, IObjStruct }
import genarators

pub fn new(obj IObjStruct, f Format) IGenerator {
	if f == .json {
		return genarators.GeneratorJson{obj}
	} else {
		panic('Not implemented')
	}
}
