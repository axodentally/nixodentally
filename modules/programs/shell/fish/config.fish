# Emulates vim's cursor shape behavior
# Set the normal and visual mode cursors to a block
set fish_cursor_default block
# Set the insert mode cursor to a line
set fish_cursor_insert line
# Set the replace mode cursors to an underscore
set fish_cursor_replace_one underscore
set fish_cursor_replace underscore
# Set the external cursor to a line. The external cursor appears when a command is started.
# The cursor shape takes the value of fish_cursor_default when fish_cursor_external is not specified.
set fish_cursor_external block
# The following variable can be used to configure cursor shape in
# visual mode, but due to fish_cursor_default, is redundant here
set fish_cursor_visual block

# Tide Prompt
set tide_character_color 5FD700
set tide_character_color_failure FF0000
set tide_character_icon ❯
set tide_character_vi_icon_default ❮
set tide_character_vi_icon_replace ▶
set tide_character_vi_icon_visual V
set tide_cmd_duration_bg_color normal
set tide_cmd_duration_color 87875F
set tide_cmd_duration_decimals 0
set tide_cmd_duration_icon
set tide_cmd_duration_threshold 3000
set tide_context_always_display false
set tide_context_bg_color normal
set tide_context_color_default D7AF87
set tide_context_color_root D7AF00
set tide_context_color_ssh D7AF87
set tide_context_hostname_parts 1
set tide_git_bg_color normal
set tide_git_bg_color_unstable normal
set tide_git_bg_color_urgent normal
set tide_git_color_branch 5FD700
set tide_git_color_conflicted FF0000
set tide_git_color_dirty D7AF00
set tide_git_color_operation FF0000
set tide_git_color_staged D7AF00
set tide_git_color_stash 5FD700
set tide_git_color_untracked 00AFFF
set tide_git_color_upstream 5FD700
set tide_git_icon
set tide_git_truncation_length 24
set tide_git_truncation_strategy
set tide_left_prompt_frame_enabled false
set tide_left_prompt_items 'pwd' 'git' 'character'
set tide_left_prompt_prefix
set tide_left_prompt_separator_diff_color ' '
set tide_left_prompt_separator_same_color ' '
set tide_left_prompt_suffix
set tide_nix_shell_bg_color normal
set tide_nix_shell_color 7EBAE4
set tide_nix_shell_icon 
set tide_jobs_number_threshold 1000
set tide_os_bg_color normal
set tide_os_color normal
set tide_os_icon 
set tide_private_mode_bg_color normal
set tide_private_mode_color FFFFFF
set tide_private_mode_icon 
set tide_prompt_add_newline_before false
set tide_prompt_color_frame_and_connection 6C6C6C
set tide_prompt_color_separator_same_color 949494
set tide_prompt_icon_connection ' '
set tide_prompt_min_cols 34
set tide_prompt_pad_items false
set tide_prompt_transient_enabled false
set tide_pwd_bg_color normal
set tide_pwd_color_anchors 00AFFF
set tide_pwd_color_dirs 0087AF
set tide_pwd_color_truncated_dirs 8787AF
set tide_pwd_icon
set tide_pwd_icon_home
set tide_pwd_icon_unwritable 
set tide_pwd_markers '.bzr' '.citc' '.git' '.hg' '.node-version' '.python-version' '.ruby-version' '.shorten_folder_marker' '.svn' '.terraform' 'Cargo.toml' 'composer.json' 'CVS' 'go.mod' 'package.json'
set tide_right_prompt_frame_enabled false
set tide_right_prompt_items 'status' 'cmd_duration' 'context' 'jobs' 'nix_shell' 'time'
set tide_right_prompt_prefix ' '
set tide_right_prompt_separator_diff_color ' '
set tide_right_prompt_separator_same_color ' '
set tide_right_prompt_suffix
set tide_status_bg_color normal
set tide_status_bg_color_failure normal
set tide_status_color 5FAF00
set tide_status_color_failure D70000
set tide_status_icon ✔
set tide_status_icon_failure ✘
set tide_time_bg_color normal
set tide_time_color 5F8787
set tide_time_format '%T'
set tide_vi_mode_bg_color_default normal
set tide_vi_mode_bg_color_insert normal
set tide_vi_mode_bg_color_replace normal
set tide_vi_mode_bg_color_visual normal
set tide_vi_mode_color_default 949494
set tide_vi_mode_color_insert 87AFAF
set tide_vi_mode_color_replace 87AF87
set tide_vi_mode_color_visual FF8700
set tide_vi_mode_icon_default D
set tide_vi_mode_icon_insert I
set tide_vi_mode_icon_replace R
set tide_vi_mode_icon_visual V

zoxide init fish | source
