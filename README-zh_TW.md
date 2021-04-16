<!-- Badge for License -->
<div align="right">

  [![](https://img.shields.io/github/license/romainl/idiomatic-vimrc.svg?style=flat-square)](./LICENSE)

</div>

<!-- Logo -->
<p align="center">
  <img src="https://i.imgur.com/C6mxszA.png" alt="Idiomatic VIMRC" height="150px">
</p>

<!-- Title and Description -->
<div align="center">

# 慣用的 `vimrc`

🔨 _一份刻劃屬於你自己的 Vim/NeoVim 設定（`vimrc`） 的導引指南_

</div>

<details><summary><b>Read in Other Avaiable Translations</b></summary>
<p>

<div align="center">

[🇺🇸 English](./README.md) ・ [🇹🇼 Traditional Chinese](./README-zh_TW.md)

</div>

<p>
</details>

## 前言（Preface）

與那些你可以在網絡上找到許多所謂的發行版（distribution）、模板（template）或 Awesome-vimrc 有所不同，這個倉庫並沒有提供一份實際的 `vimrc` 檔案。因此請勿將其複製到您的 `$HOME` 目錄中，並且期望它能夠正常工作。

這個倉庫的目的，在於記錄那些經過考驗的 Vim 配置的最佳實踐；請將這份文件作為參考，而非使用 Vim 的起點。

除此之外，個人的 `vimrc` 設定檔將會隨著你 Vim 功夫（Vim-fu）的提升和個人需求有所變化，它將會隨著時間的推移而增長、縮小與發展。借鑑他人的 `vimrc` 固然是一個有趣的練習，但應該避免去尋找不存在問題的解決方案。

Remember, kids... **Pandajail** is where pandas are sent when you use someone else's `vimrc`. Don't be the vimmer responsible for this:

![pandajail](https://i.chzbgr.com/maxW500/7518742016/h59D3B471/)

## 目錄（Table of Contents）

- [前言（Preface）](#前言preface)
- [目錄（Table of Contents）](#目錄table-of-contents)
- [檔案目錄（Files and Directories）](#檔案目錄files-and-directories)
- [雜項建議（Miscellaneous Advice）](#雜項建議miscellaneous-advice)
- [設置選項（Options）](#設置選項options)
- [鍵盤映射（Mappings）](#鍵盤映射mappings)
- [使用變數（Variables）](#使用變數variables)
- [自訂命令（Custom Commands）](#自訂命令custom-commands)
- [自訂函數（Custom Functions）](#自訂函數custom-functions)
- [自動命令（Auto Commands）](#自動命令auto-commands)
- [條件判斷（Conditionals）](#條件判斷conditionals)
- [🚧 色彩配置 (Colors)](#-色彩配置-colors)
- [擴充插件（Plugins）](#擴充插件plugins)
  - [Vim 8 新特性：套件（packages）](#vim-8-新特性套件packages)
- [建議設定（提供給開發人員的最小化建議設定）](#建議設定提供給開發人員的最小化建議設定)

## 檔案目錄（Files and Directories）

除非你 **真的** 知道自己在做什麼，否則在自定義 Vim 相關設定時，所有的操作都不會在發生 `$HOME` 目錄之外：

- 對於 Linux/BSD 作業系統，家目錄 `$HOME` 通常代表 `/home/<USERNAME>/`
- 對於 macOS 作業系統，家目錄 `$HOME` 通常代表 `/Users/<USERNAME>/`
- 對於 Windows 作業系統，家目錄 `$HOME` 通常代表 `C:\Users\<USERNAME>\`

自定義 Vim 的過程，通常會涉及編輯主要配置文件 `vimrc` 以及在執行目錄（稱為 `vimfiles`）下移動檔案。

其中，你的 `vimrc` 檔案以及 `vimfiles` 目錄，其規範位置在上述提及的 `$HOME` 目錄下：

| 作業系統  | `vimrc`        | `vimfiles`        |
| --------- | -------------- | ----------------- |
| UNIX-like | `$HOME/.vimrc` | `$HOME/.vim/`     |
| Windows   | `$HOME\_vimrc` | `$HOME\vimfiles\` |

從 Vim 7.4 開始，你也可以將 `vimrc` 檔案放置在 `vimfiles` 目錄中。這是一個很好的主意，因為這樣一來可以更加輕鬆地移動你的使用配置。下述內容為你提供了一個在 Vim 7.4 版本中使用的乾淨設置：

| System    | Location               |
| --------- | ---------------------- |
| UNIX-like | `$HOME/.vim/vimrc`     |
| Windows   | `$HOME\vimfiles\vimrc` |

當你決定將你的 `vimrc` 設定移到 `vimfiles` 目錄中時，請牢記以下幾點：

- 使用 `vimrc` 即可，不需要添加前綴的句點（`.vimrc`）或底線（`_vimrc`）
- 確保 `.vimrc` 或 `_vimrc` 沒有被創建符號連結（Symbolic Link），畢竟你要做的實際上是 **移動** 而不是複制

## 雜項建議（Miscellaneous Advice）

- 不要使用簡短名稱，那是弊大於利（ONLY cons and ZERO pros）
- 學習如何使用 Vim 說明文件是對於 VIM 初學者最有用的一件事：

    ```vim
    :help :command
    :help function()
    :help 'option'
    :help i_ctrl-a
    :helpgrep foo
    :help get<C-d>
    <C-]> on an highlighted tag to jump to the corresponding entry
    <C-t> to come back
    ```

- 在添加任何內容到你的 `vimrc` 設定之前，總是先參考 `:help` 中的相關內容
- 如果 `vimrc` 設定存放在預設的位置，則不需要設置 `set nocompatible`
- 設置 `set background=dark` 並不像你所想的那樣
- 設置 `set t_Co=256` 是一個壞主意，你應該正確設定終端模擬器
- 設置 `set paste` 會有許多討人厭的副作用，別把它放在你的 `vimrc` 設定中
- 如果你有許多針對特定檔案類型的自動命令，請考慮將這些設置移至正確文件類型的擴充插件下：

    ```
    ~/.vim/after/ftplugin/php.vim
    ```

- 如果你有許多自訂函數，考慮將他們存放在 `autoload/` 目錄下，詳見 `:help autoload`：

    ```
    " ~/.vim/autoload/myfunctions.vim
    call myfunctions#foo()
    ```

- 透過 Vim 可以瀏覽本地與遠端的檔案系統，並集成 `ack`、`ag` 或 `rg` 指令工具來導航、補全與編譯程式；編輯時運行語法檢查器；閱讀文件；透過外部命令過濾文字內容……等。在安裝任何擴充插件之前，請確保自己已經用盡 Vim 的既有特性。

## 設置選項（Options）

共有三種選項：

- 布林選項（boolean options）
- 字串選項（string options）
- 數字選項（number options）

查看選項的值：

- 使用 `:set option?` 查看選項的值
- 使用 `:verbose set option?` 查看最後設定位置

設定布林選項：

```vim
" 以下的 booloption 並不是一個實際的選項
set booloption      " Set booloption.
set nobooloption    " Unset booloption.

set booloption!     " Toggle booloption.

set booloption&     " Reset booloption to its default value.
```

設定字串選項：

```vim
" 以下的 stroption 並不是一個實際的選項
set stroption=baz   " baz

set stroption+=buzz " baz,buzz
set stroption^=fizz " fizz,baz,buzz
set stroption-=baz  " fizz,buzz

set stroption=      " Unset stroption.

set stroption&      " Reset stroption to its default value.
```

設定數字選項：

```vim
" 以下的 numoption 並不是一個實際的選項
set numoption=1     " 1

set numoption+=2    " 1 + 2 = 3
set numoption-=1    " 3 - 1 = 2
set numoption^=8    " 2 * 8 = 16
```

## 鍵盤映射（Mappings）

- 不要再映射後添加註解，那並沒有作用
- 使用 `:map <F6>` 按鍵 <kbd>F6</kbd> 在什麼模式下映射了什麼
- 使用 `:verbose map <F6>` 查看最後綁定位置
- 詳見 `:help key-notation`
- 命令 `:map` 和 `:map!` 太過泛用
  - 使用 `:nmap` 進行 Normal Mode 下的映射
  - 使用 `:imap` 進行 Insert Mode 下的映射
  - 使用 `:xmap` 進行 Visual Mode 下的映射
- 詳見 `:help map-commands`

在你打算在映射中使用預設命令時，使用非遞迴映射（這幾乎能滿足你所需要的大多數狀況）：

```vim
nnoremap <key> yyp
```

在你打算在映射中使用其他命令時，使用遞迴映射：

```vim
nnoremap b     B
nmap     <key> db
```

在映射中執行指令：

```vim
" 執行單一指令
nnoremap <key> :MyCommand<CR>

" 執行多個指令
nnoremap <key> :MyCommand <bar> MyOtherCommand <bar> SomeCommand<CR>
```

在映射中呼叫函數：

```vim
nnoremap <key> :call SomeFunction()<CR>
```

## 使用變數（Variables）

與絕大多數的腳本語言一樣，我們可以在 VimScript 中使用變數（variable）。

定義變數時使用 `:let` 命令，刪除變數時使用 `:unlet` 命令：

```vim
" 定義變數
let variable = value

" 刪除變數
unlet variable
```

在 Vim 中，可以透過在變數名稱前加上一個字母和一個冒號來限定變數的作用範圍，插件作者使用了這項特性來提供選項配置：

```vim
let g:plugin_variable = 1
```

詳見 `:help internal-variables` 中的相關主題。

## 自訂命令（Custom Commands）

- 不要忘記使用 `!`（bang）來讓 Vim 在下次重新加載 `vimrc` 時覆蓋寫命令
- 自定命令必須以大寫字母開頭
- 詳見 `:help user-commands`

**範例**：

```vim
command! MyCommand call SomeFunction()
command! MyOtherCommand command | Command | command
```

## 自訂函數（Custom Functions）

- 不要忘記使用 `!`（bang）來讓 Vim 在下次重新加載 `vimrc` 時覆蓋寫函數
- 不要忘記使用 `abort` 來讓函數在出現錯誤的情況下及早中止
- 自定函數必須以大寫字母開頭
- 詳見 `:help user-functions`

**範例**：

```
function! MyFunction(foo, bar) abort
    return a:foo . a:bar
endfunction
```

## 自動命令（Auto Commands）

- 自動命令群組（autocommand groups）不僅僅可以用來組織結構，也能夠對調試臭蟲起作用。可以將它們視為可以隨意啟用／禁用的小型命名空間（namespace）
- 詳見 `:help autocommand`

**範例**：

```vim
augroup MyGroup
    " Clear the autocommands of the current group to prevent them from piling
    " up each time you reload your vimrc.
    autocmd!

    " These autocommands are fired after the filetype of a buffer is defined to
    " `foo`. Don't forget to use `setlocal` (for options) and `<buffer>`
    " (for mappings) to prevent your settings to leak in other buffers with
    " a different filetype.
    autocmd FileType foo setlocal bar=baz
    autocmd FileType foo nnoremap <buffer> <key> :command<CR>

    " This autocmd calls `MyFunction()` everytime Vim tries to create/edit
    " a buffer tied to a file in /`path/to/project/**/`.
    autocmd BufNew,BufEnter /path/to/project/**/* call MyFunction()
augroup END
```

替代方案：

```vim
" Put an empty, self-clearing group somewhere near the top of your vimrc
augroup MyGroup
    autocmd!
augroup END

" Add autocommands to that group from anywhere
autocmd MyGroup BufNew,BufEnter /path/to/project/**/* call MyFunction()
```

## 條件判斷（Conditionals）

判斷 Vim 版本，並執行對應操作：

```vim
if v:version >= 704
    " see :help v:version
endif
```

判斷 Vim 補丁版本，並執行對應操作：

```vim
if has('patch666')
    " see :help has-patch
endif
```

判斷 Vim 是否具有 `feature` 特性，並執行對應操作:

```
if has('feature')
    " see :help feature-list
endif
```

## 🚧 色彩配置 (Colors)

- GVim and MacVim (GUI Vim) can display millions of colors.
- CLI Vim is limited by the capabilities of your shell and terminal emulator.
- GUI-specific colorschemes can't be expected to work in CLI Vim.
- CLI-specific colorschemes can't be expected to work in GUI Vim.
- To determine if a pretty colorscheme is right for your environment, Look for `guibg` (means GUI support) and `ctermbg` (means CLI support).

## 擴充插件（Plugins）

原生的 Vim 可以完成許多事情，但是當內建的功能不敷使用時，我們可以仰賴它蓬勃發展的擴充插件生態系。尋找滿足以下原則的擴充插件（plugins）：

- 遵循 Vim 的哲學
- 沒有和內建特性重複
- 可以重新定義他們的映射關係
- 沒有過於瘋狂的需求或依賴項

擴充插件將只會被安裝在你的 `vimfiles` 目錄中，而不應該在其他地方！設計正確的擴充插件通常會遵循 Vim 執行目錄的結構：

- 特定檔案類型的執行腳本必須以檔案類型作為檔案名稱，並存放在 `ftplugin/` 目錄

    ```vim
    ftplugin/javascript.vim
    ```

- 特定檔案類型的縮排設定必須以檔案類型作為檔案名稱，並存放在 `indent/` 目錄

    ```vim
    indent/javascript.vim
    ```

- 特定檔案類型的語法設定必須以檔案類型作為檔案名稱，並存放在 `syntax/` 目錄

    ```vim
    syntax/javascript.vim
    ```

- 需要時才自動加載的腳本檔案，應存放在 `autoload/` 目錄

    ```vim
    autoload/foo.vim
    ```

- 擴充插件的腳本檔案，應存放在 `plugin/` 目錄

    ```vim
    plugin/foo.vim
    ```

- 擴充插件的說明文件，應存放在 `doc/` 目錄

      doc/foo.txt

過往在安裝擴充插件時，通常是將各個檔案放置到相應的目錄中……隨著插件的添加，也將使你的 `vimfiles` 目錄變得雜亂無章。

為了解決該問題，所謂的擴充插件管理器（plugin managers）應運而生，他們或多或少都秉持著一個相同的邏輯：「每個擴充插件都以子目錄的形式存放在一個公共父目錄下，並且告 Vim 在哪裡可以找到這些擴充插件」

然而，使用擴充插件管理器並不是絕對必要的，畢竟傳統方式雖然雜亂無章但依然能夠正常運作；如果你認為自己需要使用擴充插件管理器，請確保在使用你所選擇的插件管理器之前，閱讀並理解其說明文件。

### Vim 8 新特性：套件（packages）

在 Vim 8 中引入了一個名為稱為 *package* 的新方案，該方案使你可以將擴充插件組織為套件（packages），並決定要在程式啟動時自動啟用還是手動啟用：

| 目錄                           | 敘述                                     |
| ------------------------------ | ---------------------------------------- |
| `pack/{arbitrary name}/start/` | 在此目錄下的插件會在程式啟動時自動啟用   |
| `pack/{arbitrary name}/opt/`   | 在此目錄下的插件需要在程式啟動時手動啟用 |

舉例來說，以下是我的設置況狀：

- `pack/bundle/start/` 存放那些日常使用的套件
- `pack/lang/start/` 存放那些特定語言的套件

雖然這個功能有了明顯的改進，但它仍然稱不上是一個真正的擴充插件管理器，你仍然可能需要使用一個擴充插件管理工具。

詳見 `:help package`。

## 建議設定（提供給開發人員的最小化建議設定）

```VimL
" Enabling filetype support provides filetype-specific indenting,
" syntax highlighting, omni-completion and other useful settings.
filetype plugin indent on
syntax on

" `matchit.vim` is built-in so let's enable it!
" Hit `%` on `if` to jump to `else`.
runtime macros/matchit.vim

" various settings
set autoindent                 " Minimal automatic indenting for any filetype.
set backspace=indent,eol,start " Proper backspace behavior.
set hidden                     " Possibility to have more than one unsaved buffers.
set incsearch                  " Incremental search, hit `<CR>` to stop.
set ruler                      " Shows the current line number at the bottom-right
                                " of the screen.
set wildmenu                   " Great command-line completion, use `<Tab>` to move
                                " around and `<CR>` to validate.
```

[//]: # ( Vim: set spell spelllang=en: )
