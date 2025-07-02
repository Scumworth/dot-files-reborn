# Nushell Environment Config File
# This file is loaded before config.nu

# Basic environment setup
$env.HOME = "/Users/danielmcninch"

# Homebrew paths
let brew_prefix = (brew --prefix | str trim)

# OpenSSL flags for compilation
$env.LDFLAGS = $"-L($brew_prefix)/opt/openssl/lib"
$env.CPPFLAGS = $"-I($brew_prefix)/opt/openssl/include"
$env.CFLAGS = $"-I($brew_prefix)/opt/openssl/include"

# C/C++ paths for Homebrew
$env.CPATH = "/opt/homebrew/include"
$env.LIBRARY_PATH = "/opt/homebrew/lib"

# vcpkg
$env.CMAKE_TOOLCHAIN_FILE = $"($env.HOME)/vcpkg/scripts/buildsystems/vcpkg.cmake"

# FZF configuration
$env.FZF_DEFAULT_COMMAND = "fd --type file --hidden --no-ignore"

# Git pager for diff-so-fancy
$env.GIT_PAGER = "diff-so-fancy | less --tabs=4 -RFX"

# Editor configuration
$env.EDITOR = if ($env | get -i SSH_CONNECTION | is-empty) { "nvim" } else { "vim" }

# Locale settings
$env.LC_CTYPE = "en_US.UTF-8"
$env.LC_ALL = "en_US.UTF-8"

# PNPM
$env.PNPM_HOME = $"($env.HOME)/Library/pnpm"

# MANPATH
$env.MANPATH = "/usr/local/man"

# Path configuration
# Note: Nushell uses $env.PATH as a list, not a colon-separated string
$env.PATH = (
    $env.PATH 
    | split row (char esep)
    | prepend $"($env.HOME)/bin"
    | prepend "/usr/local/bin"
    | prepend $"($env.HOME)/.local/bin"
    | prepend $"($brew_prefix)/opt/grep/libexec/gnubin"
    | prepend "/Applications/Racket v8.7/bin"
    | prepend "/Applications/love_dir"
    | prepend $env.PNPM_HOME
    | uniq
)

# Starship prompt - create empty prompt hooks that will be overridden by starship
$env.STARSHIP_SHELL = "nu"
$env.PROMPT_COMMAND = {|| ""}
$env.PROMPT_COMMAND_RIGHT = {|| ""}
