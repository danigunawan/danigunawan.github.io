---
layout: post
title: Gitlab CLI dengan GLAB
modified: 2023-01-18T17:00:28+07:00
categories:
description: "Gitlab CLI dengan GLAB"
tags: [gitlab, cli, glab, gitlab cli, git cli]
image:
  background: triangular.png
comments: true
share: true
date: 2023-01-18T17:00:28+07:00
---

![GLab](https://gitlab.com/gitlab-org/cli/-/raw/main/docs/assets/glab-logo.png)

[![Go Report Card](https://goreportcard.com/badge/gitlab.com/gitlab-org/cli)](https://goreportcard.com/report/gitlab.com/gitlab-org/cli)
![Coverage](https://gitlab.com/gitlab-org/cli/badges/main/coverage.svg)
[![Mentioned in Awesome Go](https://awesome.re/mentioned-badge.svg)](https://github.com/avelino/awesome-go#version-control)
[![Gitpod Ready-to-Code](https://img.shields.io/badge/Gitpod-Ready--to--Code-blue?style=flat&logo=gitpod&logoColor=white)](https://gitpod.io/#https://gitlab.com/gitlab-org/cli/-/tree/main/)

GLab is an open source GitLab CLI tool bringing GitLab to your terminal next to where you are already working with `git` and your code without switching between windows and browser tabs. Work with issues, merge requests, **watch running pipelines directly from your CLI** among other features.

`glab` is available for repositories hosted on GitLab.com and self-managed GitLab instances. `glab` supports multiple authenticated GitLab instances and automatically detects the authenticated hostname from the remotes available in the working Git directory.

![command example](https://gitlab.com/gitlab-org/cli/-/raw/main/docs/assets/glabgettingstarted.gif)

## Table of contents

- [Table of contents](#table-of-contents)
- [Usage](#usage)
- [Demo](#demo)
- [Documentation](#documentation)
- [Installation](#installation)
  - [macOS](#macos)
  - [Windows](#windows)
  - [Linux](#linux)
    - [Homebrew](#homebrew)
    - [Snapcraft (out of date)](#snapcraft-out-of-date)
    - [Arch Linux](#arch-linux)
    - [Alpine Linux](#alpine-linux)
      - [Install a pinned version from edge](#install-a-pinned-version-from-edge)
      - [Alpine Linux Docker-way](#alpine-linux-docker-way)
    - [Nix/NixOS](#nixnixos)
    - [MPR (Debian/Ubuntu)](#mpr-debianubuntu)
      - [Prebuilt-MPR](#prebuilt-mpr)
    - [Spack](#spack)
  - [Building from source](#building-from-source)
    - [Prerequisites for building from source](#prerequisites-for-building-from-source)
- [Authentication](#authentication)
- [Configuration](#configuration)
- [Environment variables](#environment-variables)
- [Issues](#issues)
- [Contributing](#contributing)

## Usage

To get started with `glab`:

1. Follow the [installation instructions](#installation) appropriate for your operating system.
1. [Authenticate](#authentication) into your instance of GitLab.
1. Optional. Configure `glab` further to meet your needs:
   - Set any needed global, per-project, or per-host [configuration](#configuration).
   - Set any needed [environment variables](#environment-variables).

You're ready! Run `glab --help` to view a list of core commands. Commands follow this pattern:

```shell
glab <command> <subcommand> [flags]
```

Many core commands also have sub-commands. Some examples:

- List merge requests assigned to you: `glab mr list --assignee=@me`
- List review requests for you: `glab mr list --reviewer=@me`
- Approve a merge request: `glab mr approve 235`
- Create an issue, and add milestone, title, and label: `glab issue create -m release-2.0.0 -t "My title here" --label important`

## Demo

[![asciicast](https://asciinema.org/a/368622.svg)](https://asciinema.org/a/368622)

## Documentation

Read the [documentation](https://gitlab.com/gitlab-org/cli/-/tree/main/docs/source) for usage instructions or check out `glab help`.

## Installation

Download a binary suitable for your OS at the [releases page](https://gitlab.com/gitlab-org/cli/-/releases).
Other installation methods depend on your operating system.

### macOS

- Homebrew (officially supported)
  - Install with: `brew install glab`
  - Update with: `brew upgrade glab`
- [MacPorts](https://ports.macports.org/port/glab/summary):
  - Install with: `sudo port install glab`
  - Update with: `sudo port selfupdate && sudo port upgrade glab`
- Install into `usr/bin` with a shell script:
  `curl -s "https://gitlab.com/gitlab-org/cli/-/raw/main/scripts/install.sh" | sudo sh`

  Before running any install script, review its contents.

### Windows

- [WinGet](https://github.com/microsoft/winget-cli)
  - Install with: `winget install glab.glab`
  - Update with: `winget install glab.glab`
- [scoop](https://scoop.sh)
  - Install with: `scoop install glab`
  - Update with: `scoop update glab`
- Download an EXE installer or the `glab.exe` binary from the [releases page](https://gitlab.com/gitlab-org/cli/-/releases)

### Linux

- Download prebuilt binaries from the [releases page](https://gitlab.com/gitlab-org/cli/-/releases)

#### Homebrew

Installing from Homebrew is the officially supported installation method for Linux.

- Install with: `brew install glab`
- Update with: `brew upgrade glab`

#### Snapcraft ([out of date](https://gitlab.com/gitlab-org/cli/-/issues/1127))

To install `glab` from the [Snap Store](https://snapcraft.io/glab):

1. Make sure you have [snap installed](https://snapcraft.io/docs/installing-snapd) on your Linux distribution.
1. Install the package: `sudo snap install --edge glab`
1. Grant `glab` access to SSH keys: `sudo snap connect glab:ssh-keys`

[![Download from the Snap Store](https://snapcraft.io/static/images/badges/en/snap-store-black.svg)](https://snapcraft.io/glab)

#### Arch Linux

For Arch Linux, `glab` is available:

- From the [`community/glab`](https://archlinux.org/packages/community/x86_64/glab/) package.
- By downloading and installing an archive from the
  [releases page](https://gitlab.com/gitlab-org/cli/-/releases).
- From the [Snap Store](https://snapcraft.io/glab), if
  [snap](https://snapcraft.io/docs/installing-snap-on-arch-linux) is installed.
- Installing with the package manager: `pacman -S glab`

#### Alpine Linux

`glab` is available on the [Alpine Community Repository](https://git.alpinelinux.org/aports/tree/community/glab?h=master) as `glab`.

When installing, use `--no-cache` so no `apk update` is required:

```shell
apk add --no-cache glab
```

##### Install a pinned version from edge

To ensure that by default edge is used to get the latest updates. We need the edge repository in `/etc/apk/repositories`.

Afterwards you can install it with `apk add --no-cache glab@edge`

We use `--no-cache` so an `apk update` is not required.

```shell
echo "@edge http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
apk add --no-cache glab@edge
```

##### Alpine Linux Docker-way

Use edge directly

```shell
FROM alpine:3.13
RUN apk add --no-cache glab
```

Fetching latest glab version from edge

```shell
FROM alpine:3.13
RUN echo "@edge http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
RUN apk add --no-cache glab@edge
```

#### Nix/NixOS

Nix (NixOS) users can install from [nixpkgs](https://search.nixos.org/packages?channel=unstable&show=glab&from=0&size=30&sort=relevance&query=glab) with the command `nix-env -iA nixos.glab`.

#### MPR (Debian/Ubuntu)

`glab` is available inside the [makedeb package repository](https://mpr.makedeb.org/packages/glab). To install, run the following:

```shell
git clone 'https://mpr.makedeb.org/glab'
cd glab/
makedeb -si
```

##### Prebuilt-MPR

The above method downloads glab from source and builds it before packaging it into a `.deb` package. If you don't want to compile or just want a prebuilt package, you can also install glab from the Prebuilt-MPR:

1. Set up [the Prebuilt-MPR on your system](https://docs.makedeb.org/prebuilt-mpr/getting-started/#setting-up-the-repository).
1. Install with the command `sudo apt install glab`.

#### Spack

- To install: `spack install glab`.
- To update: `spack uninstall glab && spack install glab`

### Building from source

If a supported binary for your OS is not found at the [releases page](https://gitlab.com/gitlab-org/cli/-/releases), you can build from source:

#### Prerequisites for building from source

- `make`
- Go 1.18+

To build from source:

1. Run the command `go version` to verify that Go version 1.18 or later is installed.
   If `go` is not installed, follow instructions on [the Go website](https://go.dev/doc/install).
1. Clone this repository: `git clone https://gitlab.com/gitlab-org/cli.git glab`
1. Change into the project directory: `cd glab`
1. If you have `$GOPATH/bin` or `$GOBIN` in your `$PATH`, run `make install` to install in `$GOPATH/bin`).
1. If you do not have `$GOPATH/bin` or `$GOBIN` in your `$PATH`:
   1. Run `make` to build the project.
   1. Run `export PATH=$PWD/bin:$PATH` to update your PATH with the newly compiled project.
1. Run `glab version` to confirm that it worked.

## Authentication

To authenticate your installation of `glab`:

1. Get a GitLab personal access token with at least the `api`
   and `write_repository` scopes. Use the method appropriate for your instance:
   - For GitLab.com, create one at the [Personal access tokens](https://gitlab.com/-/profile/personal_access_tokens) page.
   - For self-managed instances, visit `https://gitlab.example.com/-/profile/personal_access_tokens`,
     modifying `gitlab.example.com` to match the domain name of your instance.
1. Start interactive setup: `glab auth login`
1. Authenticate with the method appropriate for your GitLab instance:
   - For GitLab SaaS, authenticate against `gitlab.com` by reading the token
     from a file: `glab auth login --stdin < myaccesstoken.txt`
   - For self-managed instances, authenticate by reading from a file:
     `glab auth login --hostname salsa.debian.org --stdin < myaccesstoken.txt`
   - Authenticate with token and hostname: `glab auth login --hostname gitlab.example.org --token xxxxx`
     Not recommended for shared environments.

## Configuration

By default, `glab` follows the
[XDG Base Directory Spec](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html).
Configure it globally, locally, or per-host:

- **Globally**: run `glab config set --global editor vim`.
  - The global configuration file is available at `~/.config/glab-cli`.
  - To override this location, set the `GLAB_CONFIG_DIR` environment variable.
- **The current directory**: run `glab config set editor vim` in any folder in a Git repository.
  - The local configuration file is available at `.git/glab-cli` in the current working Git directory.
- **Per host**: run `glab config set editor vim --host gitlab.example.org`, changing
  the `--host` parameter to meet your needs.
  - Per-host configuration info is always stored in the global configuration file, with or without the `global` flag.

## Environment variables

- `GITLAB_TOKEN`: an authentication token for API requests. Setting this avoids being
  prompted to authenticate and overrides any previously stored credentials.
  Can be set in the config with `glab config set token xxxxxx`
- `GITLAB_URI` or `GITLAB_HOST`: specify the URL of the GitLab server if self-managed (eg: `https://gitlab.example.com`). Default is `https://gitlab.com`.
- `GITLAB_API_HOST`: specify the host where the API endpoint is found. Useful when there are separate (sub)domains or hosts for Git and the API endpoint: defaults to the hostname found in the Git URL
- `GITLAB_REPO`: Default GitLab repository used for commands accepting the `--repo` option. Only used if no `--repo` option is given.
- `GITLAB_GROUP`: Default GitLab group used for listing merge requests, issues and variables. Only used if no `--group` option is given.
- `REMOTE_ALIAS` or `GIT_REMOTE_URL_VAR`: `git remote` variable or alias that contains the GitLab URL.
  Can be set in the config with `glab config set remote_alias origin`
- `VISUAL`, `EDITOR` (in order of precedence): the editor tool to use for authoring text.
  Can be set in the config with `glab config set editor vim`
- `BROWSER`: the web browser to use for opening links.
   Can be set in the configuration with `glab config set browser mybrowser`
- `GLAMOUR_STYLE`: environment variable to set your desired Markdown renderer style
  Available options are (`dark`|`light`|`notty`) or set a [custom style](https://github.com/charmbracelet/glamour#styles)
- `NO_COLOR`: set to any value to avoid printing ANSI escape sequences for color output.
- `FORCE_HYPERLINKS`: set to `1` to force hyperlinks to be output, even when not outputting to a TTY

---
stage: Create
group: Code Review
info: To determine the technical writer assigned to the Stage/Group associated with this page, see https://about.gitlab.com/handbook/product/ux/technical-writing/#assignments
---

# GitLab CLI - `glab`

GLab is an open source GitLab CLI tool. It brings GitLab to your terminal:
next to where you are already working with Git and your code, without
switching between windows and browser tabs.

- Work with issues.
- Work with merge requests.
- Watch running pipelines directly from your CLI.

![command example](https://gitlab.com/gitlab-org/cli/-/raw/main/docs/assets/command-example.png)

The GitLab CLI uses commands structured like `glab <command> <subcommand> [flags]`
to perform many of the actions you normally do from the GitLab user interface:

```shell
# Sign in
glab auth login --stdin < token.txt

# View a list of issues
glab issue list

# Create merge request for issue 123
glab mr for 123

# Check out the branch for merge request 243
glab mr checkout 243

# Watch the pipeline in progress
glab pipeline ci view

# View, approve, and merge the merge request
glab mr view
glab mr approve
glab mr merge
```

## Core commands

- `glab alias`
- `glab api`
- `glab auth`
- `glab ci`
- `glab issue`
- `glab label`
- `glab mr`
- `glab project`
- `glab release`
- `glab snippet`
- `glab ssh-key`
- `glab user`
- `glab variable`

## Install the CLI

Installation instructions are available in the GLab
[`README`](https://gitlab.com/gitlab-org/cli/#installation).

## Authenticate with GitLab

To authenticate with your GitLab account, run `glab auth login`.
`glab` respects tokens set using `GITLAB_TOKEN`.

## Report issues

Open an issue in the [`gitlab-org/cli` repository](https://gitlab.com/gitlab-org/cli/issues/new)
to send us feedback.

## Related topics

- [Install the CLI](https://gitlab.com/gitlab-org/cli/-/blob/main/README.md#installation)
- [Documentation](https://gitlab.com/gitlab-org/cli/-/tree/main/docs/source)
- The extension source code is available in the
  [`cli`](https://gitlab.com/gitlab-org/cli/) project.

## Clone With Gitlab Self Hosted (PoC)
- glab auth login 
- select self hosted
- using https method and your token access
- use the command below

{% highlight bash %} 
GITLAB_HOST=GITLAB_SELF_HOSTED glab repo clone groupname/path/project_name
GITLAB_HOST=GITLAB_SELF_HOSTED glab repo clone yourgitlabname/project_name
- Clone by group subdir with namespace
GITLAB_HOST=GITLAB_SELF_HOSTED glab repo clone -g groupname/subdir -paginate
- Clone all by group name with namespace   
GITLAB_HOST=GITLAB_SELF_HOSTED glab repo clone -g groupname -p
- Cloner all and subdir by group name with namespace 
GITLAB_HOST=GITLAB_SELF_HOSTED glab repo clone -g groupname/subdir/pathname -p
{% endhighlight %}

Refferences : 
- Install: https://gitlab.com/gitlab-org/cli/#installation
- CLI : https://gitlab.com/gitlab-org/cli/-/blob/main/docs/source/repo/clone.md
- Demo : https://asciinema.org/a/368622
