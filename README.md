<pre align="center">
                                                                              
     **                            ***           ***                          
      **                  *      ** ***    *      ***                         
      **                 **     **   ***  ***      **                         
      **                 **     **         *       **                         
      **      ****     ******** **                 **                 ****    
  *** **     * ***  * ********  ******   ***       **       ***      * **** * 
 *********  *   ****     **     *****     ***      **      * ***    **  ****  
**   ****  **    **      **     **         **      **     *   ***  ****       
**    **   **    **      **     **         **      **    **    ***   ***      
**    **   **    **      **     **         **      **    ********      ***    
**    **   **    **      **     **         **      **    *******         ***  
**    **   **    **      **     **         **      **    **         ****  **  
**    **    ******       **     **         **      **    ****    * * **** *   
 *****       ****         **    **         *** *   *** *  *******     ****    
  ***                            **         ***     ***    *****              

</pre>

## Setup

```bash
# Clone bare repo
git clone --bare <repo-url> $HOME/.dotfiles
alias dot='git --git-dir="$HOME/.dotfiles" --work-tree="$HOME"'
dot checkout
dot submodule update --init

# Dependencies
# zsh, ghostty, tmux, neovim
# fzf, fd, ripgrep, bat, zoxide, lazygit, fnm

# Antidote (zsh plugin manager)
git clone --depth=1 https://github.com/mattmc3/antidote.git ~/.antidote
# Plugins auto-install on first shell open

# Tmux plugins (managed by TPM)
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# Then inside tmux: prefix (Ctrl+Space) + I

# Machine-specific overrides go in ~/.zshrc.local (gitignored)
```
