# IDIOMATIC VIMRC

Guidelines for sculpting your very own `~/.vimrc`.

Unlike the many so-called "distributions", "templates" or "awesome `vimrc`" you can find on the web, this document is ***NOT*** meant to be an actual `vimrc` or even form the basis of your own `vimrc` so don't copy it to your `$HOME` and expect it to work.

The purpose of this repository is to document battle-tested best practices regarding Vim configuration. Use it as a reference, not as a starting point.

Furthermore, a `vimrc` is something personal, that grows, shrinks and evolves over time, as you increase your Vim-fu and your needs change. While looking at other people's `vimrc` can certainly be an interesting exercise, one should refrain from looking for solutions to non-existing problems.

Remember, kids... **Pandajail** is where pandas are sent when you use someone else's `vimrc`. Don't be the vimmer responsible for this:

![pandajail](https://i.chzbgr.com/maxW500/7518742016/h59D3B471/)



## TABLE OF CONTENTS

* [Files and directories](#files-and-directories)
* [Miscellaneous advice](#miscellaneous-advice)
* [Options](#options)
* [Mappings](#mappings)
* [Variables](#variables)
* [Custom commands](#custom-commands)
* [Custom functions](#custom-functions)
* [Autocommands](#autocommands)
* [Conditionals](#conditionals)
* [Colors (WIP)](#colors-wip)
* [Plugins](#plugins)
* [Suggested minimal settings for programming](#suggested-minimal-settings-for-programming)



## FILES AND DIRECTORIES

Unless you *really* know what you are doing, whatever you do to customize Vim should NEVER happen outside of `$HOME`:

- on Linux, BSD, and Cygwin, `$HOME` is usually `/home/username/`,
- on Mac OS X, `$HOME` is `/Users/username/`,
- on Windows, `$HOME` is usually `C:\Users\username\`.

Customizing Vim usually involves editing its main configuration file, called `vimrc`, and moving files around your own runtime directory, called `vimfiles`.

The canonical location for your `vimrc` file and `vimfiles` directory is at the root of the `$HOME` directory mentioned above:

System | `vimrc` | `vimfiles`
---|---|---
UNIX-like | `$HOME/.vimrc` | `$HOME/.vim/`
Windows | `$HOME\_vimrc` | `$HOME\vimfiles\`

Since Vim 7.4 it is possible to keep your lovely `vimrc` INSIDE your `vimfiles`. It is really a good idea, if only because it makes it easier to move your config around.

The following gives you a neat self-contained setup from 7.4 up:

System | Location
---|---
UNIX-like | `$HOME/.vim/vimrc`
Windows | `$HOME\vimfiles\vimrc`

Here are a few things to keep in mind if you decide to move your `vimrc` into your `vimfiles`, though:

* `.vimrc` loses its dot and `_vimrc` loses its underscore to be come `vimrc`.
* Symbolic links can mess things up in all kinds of ways so make sure your `.vimrc` or `_vimrc` is not already linked and that you actually *move* it rather than copying it.



## MISCELLANEOUS ADVICE

- Using short names like `fu` or `ai` has ONLY cons and ZERO pros. Don't.
- Learning how to use Vim's fantastic documentation is the most useful thing a Vim newcomer could do:

      :help :command
      :help function()
      :help 'option'
      :help i_ctrl-a
      :helpgrep foo
      :help get<C-d>
      <C-]> on an highlighted tag to jump to the corresponding entry
      <C-t> to come back

- Always refer to the relevant `:help` before adding *anything* to your `vimrc`.
- You don't need `set nocompatible` if you have a custom `vimrc` at the expected location (see above).
- `set background=dark` doesn't do what you think it does.
- `set t_Co=256` is a bad idea. Vim sets it on its own depending on `$TERM` so set your terminal up properly instead.
- `set paste` has a lot of nasty side effects, don't put it in your `vimrc` before carefully reading `:help 'paste'`.
- If you have many autocommands for many filetype-specific settings, consider moving those settings to proper filetype plugins:

      ~/.vim/after/ftplugin/php.vim

- If you have many custom functions, consider moving them to the `autoload/` directory. See `:help autoload`:

      ~/.vim/autoload/myfunctions.vim
      call myfunctions#foo()

- Vim already gives you the ability to browse local and remote file systems, integrate `ack` or `ag` or `rg`, navigate, complete and compile your code, run syntax checkers, read documentation, filter text through external commands, etc. Make sure you have exhausted Vim's features before installing a plugin. Any plugin.



## OPTIONS

There are three kinds of options:

- boolean options,
- string options,
- number options.

Checking the value of an option:

- use `:set option?` to check the value of an option,
- use `:verbose set option?` to also see where it was last set.

Setting boolean options (`booloption` is not a real option):

    set booloption      " Set booloption.
    set nobooloption    " Unset booloption.

    set booloption!     " Toggle booloption.

    set booloption&     " Reset booloption to its default value.

Setting string options (`stroption` is not a real option):

    set stroption=baz   " baz

    set stroption+=buzz " baz,buzz
    set stroption^=fizz " fizz,baz,buzz
    set stroption-=baz  " fizz,buzz

    set stroption=      " Unset stroption.

    set stroption&      " Reset stroption to its default value.

Setting number options (`numoption` is not a real option):

    set numoption=1     " 1

    set numoption+=2    " 1 + 2 = 3
    set numoption-=1    " 3 - 1 = 2
    set numoption^=8    " 2 * 8 = 16



## MAPPINGS

- Don't put comments after mappings, it won't work.
- Use `:map <F6>` to see what is mapped to `<F6>` and in which mode.
- Use `:verbose map <F6>` to also see where it was last mapped.
- See `:help key-notation`.
- `:map` and `:map!` are too generic. Use `:nmap` for normal mode recursive mappings, `:imap` for insert mode, `:xmap` for visual mode, etc.
- See `:help map-commands`.

Use non-recursive mappings ONLY if you intend to use default commands in your mappings, which is almost always what you want:

    nnoremap <key> yyp

Use recursive mappings ONLY if you intend to use other mappings in your mappings:

    nnoremap b     B
    nmap     <key> db

Executing a command from a mapping:

    nnoremap <key> :MyCommand<CR>

Executing multiple commands from a mapping:

    nnoremap <key> :MyCommand <bar> MyOtherCommand <bar> SomeCommand<CR>

Calling a function from a mapping:

    nnoremap <key> :call SomeFunction()<CR>

NOTE: since 8.2.1978, the recommended way to call Ex commands from a mapping is with `:help <Cmd>`:

    nnoremap <key> <Cmd>MyCommand<CR>
    nnoremap <key> <Cmd>MyCommand <bar> MyOtherCommand <bar> SomeCommand<CR>
    nnoremap <key> <Cmd>call SomeFunction()<CR>



## VARIABLES

Like most scripting languages, vimscript has variables.

One can define a variable with the `:let` command:

    let variable = value

And delete it with `:unlet`:

    unlet variable

In Vim, variables can be scoped by prepending a single letter and a colon to their name. Plugin authors use that feature to mimic options:

    let g:plugin_variable = 1

Read up on the subject in `:help internal-variables`.



## CUSTOM COMMANDS

- Don't forget the bang to allow Vim to overwrite that command next time you reload your `vimrc`.
- Custom commands must start with an uppercase character.
- See `:help user-commands`.

Examples:

    command! MyCommand call SomeFunction()
    command! MyOtherCommand command | Command | command



## CUSTOM FUNCTIONS

- Don't forget the bang to allow Vim to overwrite that function next time you reload your `vimrc`.
- Don't forget the `abort` to let your function abort early in case of errors.
- Custom functions must start with an uppercase character.
- See `:help user-functions`.

Example:

    function! MyFunction(foo, bar) abort
      return a:foo . a:bar
    endfunction



## AUTOCOMMANDS

- Autocommand groups are good for organization but they can be useful for debugging too. Think of them as small namespaces that you can enable/disable at will.
- See `:help autocommand`.

Example:

    augroup MyGroup
      " Clear the autocommands of the current group to prevent them from piling
      " up each time you reload your vimrc.
      autocmd!

      " This autocmd calls the fictitious `MyFunction()` everytime Vim tries to
      " create/edit a buffer tied to a file in /`path/to/project/**/`.
      autocmd BufNew,BufEnter /path/to/project/**/* call MyFunction()
    augroup END

Alternative strategy:

    " Put an empty, self-clearing group somewhere near the top of your vimrc
    augroup MyGroup
      autocmd!
    augroup END

    " Add autocommands to that group from anywhere
    autocmd MyGroup BufNew,BufEnter /path/to/project/**/* call MyFunction()



## CONDITIONALS

Do something if Vim is the right version:

    if v:version >= 704
      " see :help v:version
    endif

Do something if Vim has the right patch-level:

    if has('patch666')
      " see :help has-patch
    endif

Do something if Vim is built with `feature`:

    if has('feature')
      " see :help feature-list
    endif



## COLORS (WIP)

- GUI Vim (`gvim`, GVim, or the MacVim GUI) can display millions of colors.
- TUI Vim (`vim` running in your terminal) is limited by the capabilities of your terminal emulator.
- GUI-specific colorschemes can't be expected to work in TUI Vim.
- TUI-specific colorschemes can't be expected to work in GUI Vim.
- To determine if a pretty colorscheme is right for your environment, Look for `guibg`/`guifg` (means GUI support) and `ctermbg`/`ctermfg` (means TUI support).



## PLUGINS

Vim does a lot but we can count on its thriving plugin ecosystem for when the built-in features are not enough. Look for plugins that:

- follow Vim's philosophy,
- don't duplicate built-in features,
- let you (re)define their mappings,
- don't have crazy requirements.

Vim plugins are to be installed in your `vimfiles` directory and **NOWHERE** else.

Properly designed plugins usually follow Vim's own runtime directory's structure:

- filetype-specific scripts are named after their filetype and go into `ftplugin/`

      ftplugin/javascript.vim

- filetype-specific indent scripts are named after their filetype and go into `indent/`

      indent/javascript.vim

- filetype-specific syntax scripts are named after their filetype and go into `syntax/`

      syntax/javascript.vim

- autoloaded scripts go into `autoload/`

      autoload/foo.vim

- plugin scripts go into `plugin/`

      plugin/foo.vim

- plugin documentation goes into `doc/`

      doc/foo.txt

Historically, the normal method for installing plugins was to put each file in its corresponding directory. It was messy and the more plugins you added the messier your `vimfiles` would get.

To solve that problem, a number of what people call "plugin managers" appeared, all more or less built around the same logic: each plugin is kept in its own directory under a common parent directory and Vim is told where to find those plugins.

Using a plugin manager is not an absolute requirement. After all, the traditional way was messy but workable, but if you think you need one, make sure you read and understand the plugin manager of your choice's README before using it.

### Vim 8's "package" feature

Vim 8 introduced a new scheme called *package* that lets you organise your plugins in so-called "packages" and decide whether they are to be enabled at startup or manually:

Directory | Description
---|---
`pack/{arbitrary name}/start/` | Plugins in this directory are enabled automatically at startup
`pack/{arbitrary name}/opt/` | Plugins in this directory are enabled manually

For example, here is my setup:

* `pack/bundle/start/` is where I put all my "quality of life" plugins,
* `pack/lang/start/` is where I put all my "language support" plugins.

While that feature is a clear improvement, it is still not an actual plugin manager and you *may* still have to use one if you need one.

See `:help package`.



## SUGGESTED MINIMAL SETTINGS FOR PROGRAMMING

The snippet below is merely a suggestion. How you customise your tools is entirely dependant on a) what you use them for and b) how well you know them, so YMMV.

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



[//]: # ( Vim: set spell spelllang=en: )
