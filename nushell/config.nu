# Nushell Config File

# Load asdf
source ~/.asdf/asdf.nu

# Aliases
alias vim = nvim
alias zshconfig = nvim ~/.zshrc
alias ohmyzsh = nvim ~/.oh-my-zsh

# The default config record
$env.config = {
    show_banner: false # disable welcome banner
    
    ls: {
        use_ls_colors: true
        clickable_links: true
    }
    
    rm: {
        always_trash: false
    }
    
    table: {
        mode: rounded
        index_mode: always
        show_empty: true
        trim: {
            methodology: wrapping
            wrapping_try_keep_words: true
            truncating_suffix: "..."
        }
    }
    
    explore: {
        help_banner: true
        exit_esc: true
        status_bar_background: { fg: "#1D1F21", bg: "#C4C9C6" }
    }
    
    history: {
        max_size: 100_000
        sync_on_enter: true
        file_format: "plaintext"
    }
    
    completions: {
        case_sensitive: false
        quick: true
        partial: true
        algorithm: "prefix"
        external: {
            enable: true
            max_results: 100
        }
    }
    
    
    cursor_shape: {
        emacs: line
        vi_insert: line
        vi_normal: block
    }
    
    footer_mode: 25
    float_precision: 2
    use_ansi_coloring: true
    bracketed_paste: true
    edit_mode: emacs
    shell_integration: {
        osc2: true
        osc7: true
        osc8: true
        osc9_9: false
        osc133: true
        osc633: true
        reset_application_mode: true
    }
    render_right_prompt_on_last_line: false
    
    hooks: {
        pre_prompt: [{||
            null  # replace with source code to run before the prompt
        }]
        pre_execution: [{||
            null  # replace with source code to run before the command
        }]
        env_change: {
            PWD: [{|before, after|
                null  # replace with source code to run when the PWD changes
            }]
        }
        display_output: {||
            if (term size).columns >= 100 { table -e } else { table }
        }
    }
    
    menus: [
        {
            name: completion_menu
            only_buffer_difference: false
            marker: "| "
            type: {
                layout: columnar
                columns: 4
                col_width: 20
                col_padding: 2
            }
            style: {
                text: green
                selected_text: green_reverse
                description_text: yellow
            }
        }
        {
            name: history_menu
            only_buffer_difference: true
            marker: "? "
            type: {
                layout: list
                page_size: 10
            }
            style: {
                text: green
                selected_text: green_reverse
                description_text: yellow
            }
        }
        {
            name: help_menu
            only_buffer_difference: true
            marker: "? "
            type: {
                layout: description
                columns: 4
                col_width: 20
                col_padding: 2
                selection_rows: 4
                description_rows: 10
            }
            style: {
                text: green
                selected_text: green_reverse
                description_text: yellow
            }
        }
    ]
    
    keybindings: [
        {
            name: completion_menu
            modifier: none
            keycode: tab
            mode: [emacs vi_normal vi_insert]
            event: {
                until: [
                    { send: menu name: completion_menu }
                    { send: menunext }
                ]
            }
        }
        {
            name: completion_previous
            modifier: shift
            keycode: backtab
            mode: [emacs, vi_normal, vi_insert]
            event: { send: menuprevious }
        }
        {
            name: history_menu
            modifier: control
            keycode: char_r
            mode: [emacs, vi_normal, vi_insert]
            event: { send: menu name: history_menu }
        }
        {
            name: next_page
            modifier: control
            keycode: char_x
            mode: emacs
            event: { send: menupagenext }
        }
        {
            name: undo_or_previous_page
            modifier: control
            keycode: char_z
            mode: emacs
            event: {
                until: [
                    { send: menupageprevious }
                    { edit: undo }
                ]
            }
        }
        {
            name: yank
            modifier: control
            keycode: char_y
            mode: emacs
            event: {
                until: [
                    {edit: pastecutbufferafter}
                ]
            }
        }
        {
            name: unix-line-discard
            modifier: control
            keycode: char_u
            mode: [emacs, vi_normal, vi_insert]
            event: {
                until: [
                    {edit: cutfromlinestart}
                ]
            }
        }
        {
            name: kill-line
            modifier: control
            keycode: char_k
            mode: [emacs, vi_normal, vi_insert]
            event: {
                until: [
                    {edit: cuttolineend}
                ]
            }
        }
    ]

}

# Custom functions
def nuopen [arg, --raw (-r)] { if $raw { open -r $arg } else { open $arg } }

# Starship prompt setup
$env.STARSHIP_SHELL = "nu"
mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
