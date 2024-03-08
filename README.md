<div align="center">

# asdf-daytona [![Build](https://github.com/CrouchingMuppet/asdf-daytona/actions/workflows/build.yml/badge.svg)](https://github.com/CrouchingMuppet/asdf-daytona/actions/workflows/build.yml) [![Lint](https://github.com/CrouchingMuppet/asdf-daytona/actions/workflows/lint.yml/badge.svg)](https://github.com/CrouchingMuppet/asdf-daytona/actions/workflows/lint.yml)

[Daytona](https://github.com/daytonaio/daytona) plugin for [mise-en-place](https://github.com/jdx/mise) and the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

- `bash`, `curl`, `tr`: generic POSIX utilities.

# Install

mise plugin:

Mise automatically installs plugins.

asdf plugin:

```shell
asdf plugin add daytona
# or
asdf plugin add daytona https://github.com/CrouchingMuppet/asdf-daytona.git
```

Daytona via mise:

```shell
# Show all installable versions
mise list-all daytona

# Set a version globally (on your ~/.mise.toml file)
mise global daytona latest

# Now daytona commands are available
daytona server
```

Check [mise-en-place](https://mise.jdx.dev/) documentation for more instructions on how to
install & manage versions.

Daytona via asdf:

```shell
# Show all installable versions (mise can be a drop-in replacement for the asdf command)
asdf list-all daytona

# Install specific version
asdf install daytona latest

# Set a version globally (on your ~/.tool-versions file)
asdf global daytona latest

# Now daytona server can be started
daytona server
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/CrouchingMuppet/asdf-lima/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Miles Parfitt](https://github.com/CrouchingMuppet/)
