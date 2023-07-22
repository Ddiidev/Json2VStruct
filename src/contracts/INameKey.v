module contracts

pub interface INameKey {
	resolver_attribute(conf IConfig) INameKey
mut:
	name string
	attributes string
}
