## 🛠️ Installation

#### install termux required packages

```shell
apt update && yes | apt upgrade && apt update && yes | apt install build-essential zip termux-api gdu gdb gdbserver gh fd fzf neovim lua-language-server jq-lsp luarocks stylua ripgrep lazygit yarn python python-pip ccls clang zig rust-analyzer git ruby  && pip install neovim && npm install -g neovim && gem install neovim;
```

#### make a backup of your current nvim and shared folder

```shell
mv ~/.config/nvim ~/.config/nvim.bak && mv ~/.local/share/nvim ~/.local/share/nvim.bak && mv ~/.local/state/nvim ~/.local/state/nvim.bak && mv ~/.cache/nvim ~/.cache/nvim.bak
```

#### clone the repository

```shell
git clone https://github.com/sohan-f/NeoVim-Conf.git ~/.config/nvim
```

#### start Neovim

```shell
nvim
```
