# Convert JSON to a struct in V.

A CLI to build a struct/entity from a data model like JSON and TOML(for now).

There is a web version([Json2V](https://ldedev.github.io/Json2V/)) built in Pure Js that can transform just json to struct.

## Roadmap

- [X] CLI
- [X] Parser JSON
- [X] Parser TOML
- [ ] Parser YAML
- [ ] Parser XML
- [ ] Web page to be more practical to use


## Demonstração





## Documentation

Stdin on linux
```shell
cat my.json | obj2V
//or
cat my.toml | obj2V -t toml
```

Stdin on windows
```batch script
type my.toml | obj2V -t toml
```

Args
```batch script
obj2V -t toml teste = 3
```

<br/>

```
Usage: obj2V [flags] [commands] [args/stdin]

Translate a json and toml to a struct vlang

Flags:
  -ku  -keyword_with_underscore  Add an underscore to the end of reserved words, otherwi
                                 se add an @ to the beginning
  -oe  -omit_empty               omit empty fields
  -sa  -struct-anon              Create anonymous sub-structs
  -t   -type                     Output type (json, toml)
       -version                  Prints version information.

Commands:
  help                           Help about the tool
  version                        Prints version information.
```
## Licença

[MIT](https://choosealicense.com/licenses/mit/)
