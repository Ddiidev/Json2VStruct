module parsers

import entities { Config }

pub fn parser(type_parser TypeParser, object string, conf Config) !string {
	if type_parser == .json {
		return parser_json(object, conf)
	}

	return 'error!'
}
