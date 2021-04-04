# dotfiles

```text
me: mom can we have cross platform configuration?
mom: we have cross platform configuration at home
cross platform configuration at home: psdotfiles x stow
```

Hey, it works for the most part?

Best with:

* [guppy0130/PSDotFiles](https://github.com/guppy0130/PSDotFiles)
* [guppy0130/git-status-cache-posh-client](https://github.com/guppy0130/git-status-cache-posh-client/)

## Further config required

### Going to *nix

* Change the path that git looks for gpg on

### Vim/Neovim

* You'll have to `stow vim neovim` since `stow neovim` will just reference files dropped by `stow vim`.
* For `deoplete`, don't forget to `pip install --user pynvim` and then `:UpdateRemotePlugins` in vim.
