# Ranger Cheatsheet
> Source: <https://gist.github.com/heroheman/aba73e47443340c35526755ef79647eb>

## General
| Shortcut | Description                 |
|----------|-----------------------------|
| `ranger` | Start Ranger                |
| `q`      | Quit Ranger                 |
| `R`      | Reload current directory    |
| `?`      | Ranger Manpages / Shortcuts |


## Movement
| Shortcut                 | Description             |
|--------------------------|-------------------------|
| `k`                      | Up                      |
| `j`                      | Down                    |
| `h`                      | Parent directory        |
| `l`                      | Subdirectory            |
| `gg`                     | Go to top of list       |
| `G`                      | Go to bottom of list    |
| `J`                      | Half page down          |
| `K`                      | Half page up            |
| `H`                      | History Back            |
| `L`                      | History Forward         |
| `~`                      | Switch the view         |
| `<Alt>j` or `<Control>d` | Scroll down the preview |
| `<Alt>k` or `<Control>u` | Scroll up the preview   |
| `i`                      | Enter the preview       |

## File Operations
| Shortcut   | Description                                    |
|------------|------------------------------------------------|
| `<Enter>`  | Open                                           |
| `r`        | Open file with                                 |
| `o`        | Change sort order                              |
| `zh`       | View hidden files                              |
| `cw`       | Rename file/s                                  |
| `yy`       | Yank / copy                                    |
| `dd`       | Cut                                            |
| `pp`       | Paste                                          |
| `/`        | Search for files `:search`                     |
| `n`        | Next match                                     |
| `N`        | Prev match                                     |


## Commands
| Shortcut   | Description                                                                |
|------------|----------------------------------------------------------------------------|
| `:`        | Execute Ranger Command                                                     |
| `!` or `s` | Execute Shell Command                                                      |
| `chmod`    | Change file Permissions                                                    |
| `S`        | Run the terminal in your current ranger window (exit to go back to ranger) |

## Tabs
| Shortcut     | Description           |
|--------------|-----------------------|
| `C-n`        | Create new tab        |
| `C-w` or `q` | Close current tab     |
| tab          | Next tab              |
| shift + tab  | Previous tab          |
| alt + [n]    | Goto / create [n] tab |
| `<Control>h` | Move tab to the left  |
| `<Control>l` | Move tab to the right |

## File substituting
| Shortcut | Description                         |
|----------|-------------------------------------|
| `%f`     | Substitute highlighted file         |
| `%d`     | Substitute current directory        |
| `%s`     | Substitute currently selected files |
| `%t`     | Substitute currently tagged files   |

### Example for substitution
`:bulkrename %s`

## Marker
| Shortcut         | Description                       |
|------------------|-----------------------------------|
| `m  + <letter>`  | Create Marker                     |
| `um  + <letter>` | Delete Marker                     |
| `'  + <letter>`  | Go to Marker                      |
| `t`              | Tag a file with an *              |
| `t"<any>`        | Tag a file with your desired mark |

## Custom

| Shortcut    | Description                                                        |
|-------------|--------------------------------------------------------------------|
| `mkd`       | Create a directory                                                 |
| `mkf`       | Create a file                                                      |
| `Z`         | Zip the selected files                                             |
| `Z`         | Tar-gz the selected files                                          |
| `X`         | Extract the (compressed) file                                      |
| `Ov`        | Open the current directory in nvim                                 |
| `Os` or `S` | Open the current directory in a shell                              |
| `Of`        | Open the current directory in the default file-browser             |
| `dT`        | Move to trash                                                      |
| `uT`        | Restore file from trash                                            |
| `F`         | Recursive search (max. 5 dirs deep). After, press 'f' to flat to 0 |
