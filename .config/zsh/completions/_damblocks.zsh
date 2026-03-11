# vim:ft=sh
# @since 2026
# zsh completion for damblocks

_damblocks() {
    local options
    options=("--fifo" "--xsetroot")
    if [ "$CURRENT" -eq 2 ]; then
        _describe 'options' options
    fi
}
compdef _damblocks damblocks
