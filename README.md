# starship_rs [![Build Status](https://github.com/DWSR/ansible-role-starship_rs/workflows/CI/badge.svg?branch=master)](https://github.com/DWSR/ansible-role-starship_rs/actions?query=workflow%3ACI)

An Ansible role to install [Starship.rs](https://starship.rs) for the current user

## Requirements

### Control Node

* `toml` Python package

### Remote Node

None

## Role Defaults

| Variable                            |   Type  |              Default Value            | Description |
|-------------------------------------|:-------:|:-------------------------------------:|-------------|
| `starship_rs_config`                | `dict`  | see `defaults/main.yml` | The configuration for Starship. See [the Starship docs](https://starship.rs/config/) for more info. |

## Dependencies

### Roles

* [dwsr.profile_d](https://galaxy.ansible.com/dwsr/profile_d)

### Collections

* [community.general](https://galaxy.ansible.com/community/general)
* [sivel.toiletwater](https://galaxy.ansible.com/sivel/toiletwater)

## Example Playbook

```yaml
- hosts: my-workstation
  roles:
    - starship_rs
  vars:
    starship_rs_config:
      battery:
        disabled: false
      directory:
        truncate_to_repo: true
      status:
        disabled: false
```

## License

MPL-2.0

## Author Information

This role was created in 2020 by [Brandon McNama](https://github.com/dwsr).

## Development

### Dev Requirements

* Ruby `2.7` or later
* Python `3.8` or later
* Poetry `1.1` or later

This repository supports [asdf](https://asdf-vm.com) for language selection.

### Installation

`bundle install --path vendor/bundle --jobs 2 --clean && poetry install --remove-untracked`

### Running linters

`poetry run pre-commit`

### Running tests

This role uses [Test Kitchen](https://kitchen.ci) and [Inspec](https://inspec.io) for testing
instead of Molecule. This is done in order to more easily support multiple testing drivers (both
`docker` and `exec`) to ease testing on multiple operating systems.

There are 2 suites:

* The `linux` suite is aimed at testing against Linux hosts using `bash` as the default shell.
  This suite uses `docker` to test multiple variants of `ubuntu`.
* The `darwin` suite is aimed at testing against MacOS using `zsh` as the default shell. This suite
  uses the `exec` driver to execute commands against the current host and is intended to be run
  against a CI runner host, such as in GitHub Actions.

To run tests, run `bundle exec poetry run kitchen test <suite name>`.
