module entities

import constants
import contracts { INameKey, IConfig }
import genarator { build_struct }
import regex

pub fn (this ObjStruct) builder_struct(conf IConfig) string {
	return build_struct(this, conf)
}

pub fn (this ObjStruct) resolver_name_type() string {
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

pub fn (this ObjStruct) resolver_name_property(conf IConfig) INameKey {
	mut final_name := ''
	for chr in this.name {
		if chr.ascii_str() == chr.ascii_str().to_upper() && !chr.is_digit() {
			final_name += '_${chr.ascii_str().to_lower()}'
		} else {
			final_name += chr.ascii_str().to_lower()
		}
	}

	final_name = if final_name[0] == `_` {
		final_name[1..]
	} else {
		final_name[0..1] + final_name[1..]
	}
	mut re := regex.regex_opt(r'[^a-zA-Z0-9_]') or { return NameKey{this.name, ''} }
	final_name = re.replace(final_name, '').replace(r'_{2,}', '_')

	current_reserved_word := constants.reserved_words.contains(final_name)

	flag_reserved_words_with_at := true // is temporary

	if current_reserved_word && flag_reserved_words_with_at {
		final_name = '@${final_name}'
	} else if current_reserved_word {
		final_name = '${final_name}_'
	}

	/*
	const replaceName = final_name !== name && !(currentReservedWord && FlagReserverdWordsWithAt) ? `json: "${name}"` : '';

	   return { name: final_name, replaceName: replaceName };
	**/

	replace_name := if final_name != this.name && !(current_reserved_word
	&& flag_reserved_words_with_at) {
		'json: "${this.name}"'
	} else {
		''
	}

	return NameKey{final_name, replace_name}
}


fn (this NameKey) construct_attribute(attrib string) string {
	mut attribs := []string{}
	if attrib == '' {
		attribs = []
	} else {
		attribs = [attrib]
	}

	flag_omit_empty := true // Substitua por false se FlagOmitEmpty for falso (Temporário)

	if flag_omit_empty {
		attribs << 'omitempty'
	}

	return match attribs.len {
		0 { '' }
		1 { '[${attribs.join("")}]' }
		else { '[${attribs.join("; ")}]' }
	}
}
