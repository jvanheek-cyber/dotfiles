# Justin's Dotfiles

Maintain a consistent environment across machines, all tracked by git to make it easy to setup on a new device or pull changes.

## Installation
`git clone --bare <REPO> $HOME/.config/dotfiles`  
`git --git-dir=$HOME/.config/dotfiles --work-tree=$HOME checkout`  
`source .profile`  
`git-dot sparse-checkout reapply`
