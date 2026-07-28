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
alias dotfiles='git --git-dir="$HOME/.dotfiles" --work-tree="$HOME"'
dotfiles checkout

# Tmux plugins (managed by TPM)
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# Then inside tmux: prefix (Ctrl+Space) + I

# Machine-specific overrides go in ~/.zshrc.local (gitignored)
```
