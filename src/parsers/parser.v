module parsers

import entities { ObjStruct }
import contracts { IConfig }
import parsers.module_parser_toml
import parsers.module_parser_json

pub fn parser(object string, conf IConfig) !string {
	return parser_build_struct(object, conf)!.builder_struct(conf)!
}

pub fn parser_build_struct(object string, conf IConfig) !ObjStruct {
	return match conf.type_parser {
		.json {
			module_parser_json.parser(object, conf)!
		}
		.toml {
			module_parser_toml.parser(object, conf)!
		}
	}
}
