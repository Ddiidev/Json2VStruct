module main

import entities.configuration { Config }
import parsers.type_object { TypeParser }
import parsers
import os
import cli

fn main() {
	mut app := cli.Command{
		name: 'obj2V'
		disable_man: true
		disable_help: true
		version: '0.0.2'
		usage: '[args/stdin]'
		sort_flags: true
		description: r'Translate a json and toml to a struct vlang'
		commands: [
			cli.Command{
				name: 'help'
				description: 'Help about the tool'
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
	mut data := cmd.args.join('')
	if data.len_utf8() == 0 {
		data = os.get_raw_stdin().bytestr()
	}

	mut type_parser := match cmd.flags.get_string('type')! {
		'toml' { TypeParser.toml }
		else { TypeParser.json }
	}

	built_structure := parsers.parser(data, Config{
		struct_anon: cmd.flags.get_bool('struct-anon') or { false }
		omit_empty: cmd.flags.get_bool('omit_empty') or { false }
		reserved_word_with_underscore: cmd.flags.get_bool('reserved_word_with_underscore') or {
			false
		}
		type_parser: type_parser
	})!

	print(built_structure)
}
