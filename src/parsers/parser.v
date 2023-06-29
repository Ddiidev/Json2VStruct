module parsers

import entities { Config, ObjStruct }

pub fn parser(type_parser TypeParser, object string, conf Config) !string {
	if type_parser == .json {
		return parser_build_struct(type_parser, object, conf)!.builder_struct(conf)!
	}

	return 'error!'
}

pub fn parser_build_struct(type_parser TypeParser, object string, conf Config) !ObjStruct {
	if type_parser == .json {
		return parser_json(object, conf)!
	}

	return error('error!')
}
