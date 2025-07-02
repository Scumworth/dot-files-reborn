# Nushell Environment Config File
# This file is loaded before config.nu

# Basic environment setup
$env.HOME = "/Users/danielmcninch"

# Homebrew paths - hardcode for Apple Silicon Mac
let brew_prefix = "/opt/homebrew"

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

# ASDF configuration
$env.ASDF_DIR = $"($env.HOME)/.asdf"

# Path configuration
# Note: Nushell uses $env.PATH as a list, not a colon-separated string
$env.PATH = [
    # User-specific paths (highest priority)
    $"($env.HOME)/bin"
    $"($env.HOME)/.local/bin"
    
    # Programming language tools
    $"($env.HOME)/.cargo/bin"
    $"($env.HOME)/go/bin"
    $"($env.HOME)/.deno/bin"
    
    # ASDF version manager
    $"($env.HOME)/.asdf/shims"
    $"($env.HOME)/.asdf/bin"
    $"($env.HOME)/.asdf/installs/nodejs/22.1.0/bin"
    $"($env.HOME)/.asdf/plugins/nodejs/shims"
    
    # Package managers
    $env.PNPM_HOME
    
    # Homebrew
    $"($brew_prefix)/bin"
    $"($brew_prefix)/sbin"
    $"($brew_prefix)/opt/grep/libexec/gnubin"
    
    # Applications
    "/Applications/Racket v8.7/bin"
    "/Applications/love_dir"
    
    # System paths
    "/usr/local/bin"
    "/usr/bin"
    "/bin"
    "/usr/sbin"
    "/sbin"
]

# Starship prompt - create empty prompt hooks that will be overridden by starship
$env.STARSHIP_SHELL = "nu"
$env.PROMPT_COMMAND = {|| ""}
$env.PROMPT_COMMAND_RIGHT = {|| ""}
