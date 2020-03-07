# disable "greeting"
set fish_greeting

function fish_prompt --description 'Write out the prompt'
    set -l last_pipestatus $pipestatus

    # Color the prompt differently when we're root
    set -l user_color 'green'
    set -l suffix '$'
    if contains -- $USER root toor
        set user_color 'red'
        set suffix '#'
    end

    # Write pipestatus
    set -l prompt_status (__fish_print_pipestatus " [" "]" "|" (set_color $fish_color_status) (set_color --bold $fish_color_status) $last_pipestatus)

    # Replace /home/<user> with ~
    set -l realhome ~
    set -l prompt_workdir (string replace -r '^'"$realhome"'($|/)' '~$1' $PWD)

    set -l normal (set_color normal)
    echo -n -s (set_color --bold $user_color) "$USER" @ (prompt_hostname) $normal ' ' (set_color --bold blue) $prompt_workdir $normal (fish_vcs_prompt) $normal ' ' $prompt_status $suffix " "
end
