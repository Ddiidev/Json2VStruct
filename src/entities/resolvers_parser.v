module entities

import constants
import contracts { IConfig, INameKey }
import genarator { build_struct }
import regex

pub fn (this ObjStruct) builder_struct(conf IConfig) !string {
	return build_struct(this, conf)!
}

fn (this ObjStruct) resolver_name_type() string {
	mut final_name := ''
	mut is_upper := false

	for chr in this.name {
		if chr !in [`_`, ` `] {
			if is_upper {
				final_name += chr.ascii_str().to_upper()
				is_upper = false
			} else {
				final_name += chr.ascii_str()
			}
		} else {
			is_upper = true
		}
	}

	mut re := regex.regex_opt(r'[^a-zA-Z0-9_]') or { return this.name }
	final_name = final_name[0..1].to_upper() + final_name[1..]
	final_name = re.replace(final_name, '')

	return final_name
}

fn (this ObjStruct) resolver_name_property(conf IConfig) INameKey {
	mut final_name := ''
	for chr in this.name {
		chr_ascii := chr.ascii_str()
		if chr_ascii == chr_ascii.to_upper() && !chr.is_digit() {
			final_name += '_${chr_ascii.to_lower()}'
		} else {
			final_name += chr_ascii.to_lower()
		}
	}

	final_name = if final_name.len > 0 && final_name[0] == `_` {
		final_name[1..]
	} else {
		final_name
	}
	mut re := regex.regex_opt(r'[^a-zA-Z0-9_]') or { return NameKey{this.name, ''} }
	final_name = re.replace(final_name, '')

	re = regex.regex_opt(r'_{2,}') or { return NameKey{final_name, ''} }
	final_name = re.replace(final_name, r'_')

	current_reserved_word := constants.reserved_words.contains(final_name)

	if current_reserved_word && !conf.reserved_word_with_underscore {
		final_name = '@${final_name}'
	} else if current_reserved_word {
		final_name = '${final_name}_'
	}

	replace_name := if final_name != this.name && !(current_reserved_word
		&& !conf.reserved_word_with_underscore) {
		'${conf.type_parser}: "${this.name}"'
	} else {
		''
	}

	return NameKey{final_name, replace_name}
}

fn (this NameKey) resolver_attribute(conf IConfig) INameKey {
	mut attribs := []string{}
	if this.attributes == '' {
		attribs = []
	} else {
		attribs = [this.attributes]
	}

	if conf.omit_empty {
		attribs << 'omitempty'
	}

	return match attribs.len {
		0 {
			NameKey{this.name, ''}
		}
		1 {
			NameKey{this.name, '[${attribs.join('')}]'}
		}
		else {
			NameKey{this.name, '[${attribs.join('; ')}]'}
		}
	}
}
