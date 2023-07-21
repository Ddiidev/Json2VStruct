module main

import entities.configuration { Config }
import parsers.type_object { TypeParser }
import parsers
import os
import cli

// const str_simple_js = r'[1,2,3]'

// const str_simple_js = r'
// 	{
// 		"name": "André",
// 		"age": 25,
// 		"is_people": true,
// 		"height": 1.75,
// 		"childrens": [
// 			{
// 				"name": "Dante",
// 				"age": 1.8,
// 				"is_people": true,
// 				"height": 0.9,
// 				"x": {"então":1}
// 			}
// 		],
// 		"type": [0,1,2]
// 	}
// '

const str_obj_simple = r'
name = "André"
age = 25
is_people = true
height = 1.75

[[childrens]]
name = "Dante"
age = 1.8
is_people = true
height = 0.9

  [childrens.x]
  "então" = 1
'

fn main() {
	mut app := cli.Command{
		name: 'V2Struct'
		disable_man: true
		disable_help: true
		description: 'Translate a json, yaml or toml to a struct in vlang'
		commands: [
			cli.Command{
				name: 'help'
				description: 'Ajuda sobre a ferramenta'
				version: '0.0.2'
				execute: fn (cmd cli.Command) ! {
					cli.print_help_for_command(cmd)!
				}
			},
		]
		flags: [
			cli.Flag{
				name: 'struct-anon'
				abbrev: 'sa'
				description: 'Create anonymous sub-structs'
				default_value: ['false']
				flag: .bool
			},
			cli.Flag{
				name: 'omit_empty'
				abbrev: 'oe'
				description: 'omit empty fields'
				default_value: ['false']
				flag: .bool
			},
			cli.Flag{
				name: 'keyword_with_underscore'
				abbrev: 'ku'
				description: 'Add an underscore to the end of reserved words, otherwise add an @ to the beginning'
				default_value: ['true']
				flag: .bool
			},
			cli.Flag{
				name: 'type'
				abbrev: 't'
				description: 'Output type (json, toml)'
				default_value: ['json']
				flag: .string
			},
		]
		execute: create_struct
	}
	app.setup()
	app.parse(os.args)
}

fn create_struct(cmd cli.Command) ! {
	type_parser := match cmd.flags.get_string('type')! {
		'toml' { TypeParser.toml }
		else { TypeParser.json }
	}

	builded_struct := parsers.parser(str_obj_simple, Config{
		struct_anon: cmd.flags.get_bool('struct-anon') or { false }
		omit_empty: cmd.flags.get_bool('omit_empty') or { false }
		reserved_word_with_underscore: cmd.flags.get_bool('reserved_word_with_underscore') or {
			false
		}
		type_parser: type_parser
	})!

	print(builded_struct)
}
