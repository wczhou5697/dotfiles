<h1 align="center"> wczhou5697's dotfiles </h1>

- [Dotfiles manager](#dotfiles-manager) 
- [Configured apps](#configured-apps) 
- [Installation](#installation)


## Dotfiles manager

This dotfiles is managed by [chezmoi](https://www.chezmoi.io/)

## Configured apps

- [nvim](https://neovim.io/) using [nvchad](https://nvchad.com/)  as base
- [zsh](https://www.zsh.org/) 
- [omz](https://ohmyz.sh/) 

## Installation

```
sh -c "$(curl -fsLS get.chezmoi.io)"
chezmoi init https://github.com/wczhou5697/dotfiles.git
chezmoi apply
```
