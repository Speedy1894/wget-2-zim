<h1 align="center">
  <img width=320 src="logo_400.png" alt="The wget-2-zim logo: The Kiwix bird, a small tear falling from its eye, huddles facing the right over a circle about the size of its head. The text, wget 2 zim, is placed atop this from the top left to the bottom right, one word at a time.">
</h1>

# `wget-2-zim` — create ZIM files for Kiwix from arbitrary websites

Wget-2-zim is a simple Bash script with some nifty tricks that can be used to archive websites on the Internet.
It does not require ServiceWorkers and will drop a ZIM file that can be read with any Kiwix reader anywhere.
The script does several things far beyond what Wget alone would do — it deletes large files,
grabs embedded images and media files from external URLs,
injects anti-cookie-banner CSS,
and all sorts of other useful things.

Please note that Wget has very limited ability to deal with Javascript,
which may cause rendering issues with some pages.
[Zimit](https://zimit.kiwix.org) is an alternative that uses the Web ARChive standard,
but it requires ServiceWorkers, which, as of 2022,
do not work with kiwix-desktop (only kiwix-android and kiwix-serve).


## Installation

First, install all dependencies.
* [Wget](https://www.gnu.org/software/wget)
* [ImageMagick](https://imagemagick.org)
* [ZIM tools](https://github.com/openzim/zim-tools)

(The following commands must be run as root or with `sudo`.)
```sh
# Debian / Ubuntu
apt update
apt install wget imagemagick zim-tools

# Red Hat / Fedora
dnf install wget imagemagick zim-tools

# Arch
pacman -S wget imagemagick zim-tools
```

Then, install the executable file to the executable directory.
```bash
install -Dpm 0755 <(wget -q -O - 'https://raw.githubusercontent.com/ballerburg9005/wget-2-zim/main/wget-2-zim.sh') /usr/local/bin/wget-2-zim
```
<!-- These are `bash`, not `sh`, because `<()` process substitution isn't valid in the latter -->

Optionally, install other documentation.
```bash
# man page
install -Dpm 0644 <(wget -q -O - 'https://raw.githubusercontent.com/ballerburg9005/wget-2-zim/main/wget-2-zim.1') /usr/local/share/man/man1/wget-2-zim.1

# bash and zsh completion, respectively
install -Dpm 0644 <(wget -q -O - 'https://raw.githubusercontent.com/ballerburg9005/wget-2-zim/main/completion/bash.bash') /usr/local/share/bash-completion/completions/wget-2-zim
install -Dpm 0644 <(wget -q -O - 'https://raw.githubusercontent.com/ballerburg9005/wget-2-zim/main/completion/zsh.zsh') /usr/local/share/zsh/site-functions/_wget-2-zim
```


## Usage

```sh
wget-2-zim [options] <url>

# Print all command-line arguments and exit
wget-2-zim --help

# Create a ZIM holding the contents of example.org
wget-2-zim https://example.org

# Do the same as before, but without waiting for download delays
wget-2-zim --turbo https://example.org

# Do the same as the first time, but with custom metadata
wget-2-zim https://example.org \
--creator 'Me' \
--description 'An example site reserved for documentation purposes' \
--timestamp
```

Once it's created, just open the `.zim` file in a ZIM viewer like [Kiwix Desktop](https://github.com/kiwix/kiwix-desktop).


## Options

wget-2-zim tries to include as much as sanely possible (like PDFs, XLSs, music, and video) in the ZIM by default.

| Option | Argument | Description | Default |
|---|---|---|---|
| `--any-max` | size\_MB | Max file size over which any files will be deleted | `128` MB |
| `--not-media-max` | size\_MB | Maximum size for non-media files (e.g., music, `.pdf`, `.xls`) | `2` MB |
| `--picture-max` | size\_MB | Maximum size for picture files | unset |
| `--document-max` | size\_MB | Maximum size for document files (e.g., `.epub`, `.pdf`, `.xls`, `.ods`) | unset |
| `--music-max` | size\_MB | Maximum size for music files | unset |
| `--video-max` | size\_MB | Maximum size for video files | unset |
| `--wget-depth` | integer | Recursion depth (use 1 or 3 for shallow copies) | 7 |
| `--include-zip` | | Exclude archives (e.g., `.zip`, `.rar`, `.7z`, `.gz`) from download | |
| `--include-exe` | | Exclude program files (e.g., `.exe`, `.msi`, `.deb`, `.rpm`) from download | |
| `--include-any` | | Download any file type | |
| `--no-overreach-media` | | Don't download media files from external domains | |
| `--overreach-any` | | Download any inlined content from external domains | |
| `--turbo` | | Disable download delays (may result in missing files) | |
| `--skip-download` | | Skip download step; use existing files in directory | |
| `--creator` | string | Custom creator string for ZIM file | "`https://github.com/ballerburg9005/wget-2-zim`" |
| `--publisher` | string | Custom publisher string for ZIM file | "`wget-2-zim, a simple easy to use script that just works`" |
| `--description` | string | Custom description for ZIM file | extracted from page title |
| `--long-description` | string | Custom long description for ZIM file | description + "`(created by wget-2-zim)`" |
| `--language` | code | ISO 639-3 language code for ZIM file | "`eng`" |
| `--output` | name | Custom output filename | domain name |
| `--timestamp` | | Add timestamp (`YYYYMMDD_hhmmss`) to ZIM filename | |
| `--working-dir` | path | Custom working directory | "`./`" + domain name |


## Running Under Windows

[Please do not use Windows](https://ballerburg.us.to/about-your-obligation-to-boycott-windows-11).
However, if you must, then there's basically one option:

1. [WSL2](https://docs.microsoft.com/en-us/windows/wsl/setup/environment) — integrated Linux environment from Microsoft; similar to a virtual machine (runs Linux binaries)

    Follow one of the many [tutorials](https://www.youtube.com/watch?v=pOZ5Pb4pHOY) to set up WSL2.
    Then, follow the instructions under "Installation"

1. [MSYS2](https://www.msys2.org/) — great tool, but **NOT VIABLE ANYMORE FOR `zim-tools`**! Don't try.


## Troubleshooting

* If you get an error ending in "`command not found`," you are missing one or more dependencies.
See the "Installation" section for instructions on installing them.

* If you get an error from `zimwriterfs` about an option being unknown, you are using an outdated version of `zim-tools`.
If you are using the latest version available to your package manager, you will be need to uninstall and build it manually.
Detailed build instructions can be found in its [source repository](https://github.com/openzim/zim-tools).


## Known Issues

* The source website can throttle you if you download too much too fast, rendering your archive incomplete.
You will notice this when you suddenly only get 404 errors, or when the script hangs often.
There are delays inside the script in various places to prevent this.
If you still experience throttling, it is probably due to total download volume over a certain time period (e.g., per day).
To solve this, you can try increasing the delays or pausing the script with CTRL+Z to continue at a later time using `fg`.

* Due to cookie-banner-removing CSS, some sites might not scroll or only show a blank box that you can't click away from.
The solution is to modify or blank out "antishit" inside the script.
This will, however, result in cookie banners and advertisements when they are present.
