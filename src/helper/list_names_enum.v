module helper

[params]
pub struct ParamGet_names_enum_setad[T] {
pub:
	type_enum   T            [required]
	source_data map[T]string
}

// get_names_enum_setad Apenas para enums com flags
pub fn get_names_enum_setad[T](param ParamGet_names_enum_setad[T]) []string {
	mut list_names := []string{}

	$for value in T.values {
		$if param.type_enum is $enum {
			if param.type_enum.has(value.value) {
				if param.source_data.len == 0 {
					list_names << value.name
				} else {
					list_names << param.source_data[value.value]
				}
			}
		}
	}
	return list_names
}
