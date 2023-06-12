module contracts

pub interface INameKey {
	construct_attribute(conf IConfig) string
mut:
	name string
	attribute_replace_name string
}
