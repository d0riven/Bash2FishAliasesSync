# Bash2FishAliasesSync

Synchronize bash's aliases with fish's aliases.

## Usage

Add the following command to the `~/.config/fish/config.fish`.
This allows you to sync the alias set via ~/.bash\_profile to ~/.config/fish/b2f\_aliases.fish and load it into fish.

```fish
bash /path/to/Bash2FishAliasesSync/aliases_sync.bash; and source ~/.config/fish/b2f_aliases.fish
```

### Option

If you want to change will load path of .bash\_profile, set the following variable (`_B2F_BASH_PROFILE`) with bash:

```fish
_B2F_BASH_PROFILE=/path/to/.bash_profile bash /path/to/Bash2FishAliasesSync/aliases_sync.bash; and source ~/.config/fish/b2f_aliases.fish
```

If you want to change the path where alias is saved, set the following variable (`_B2F_ALIASES_FILE`) to bash:

```fish
_B2F_ALIASES_FILE=/path/to/file bash /path/to/Bash2FishAliasesSync/aliases_sync.bash; and source /path/to/file
```

Note: It is necessary to change the source file path to be read.
