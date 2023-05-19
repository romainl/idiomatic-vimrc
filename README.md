# IDIOMATIC VIMRC

Guidelines for sculpting your very own `~/.vimrc`.

This document is available in the following languages:

- [English](./README.md)
- [Simplified Chinese](./README-zh_CN.md)

Unlike the many so-called "distributions", "templates" or "awesome `vimrc`" you can find on the web, this project is ***NOT*** meant to provide you with a working config, or help you bootstrap your config with opinionated "defaults", or tell you *what* to put in your config. Therefore, don't copy it to your `$HOME` and expect it to do anything.

The purpose of this project is to document battle-tested best practices regarding Vim configuration. Use it as a reference, not as a starting point.

Furthermore, a `vimrc` is something personal, that grows, shrinks and evolves over time, as you increase your Vim-fu and your needs change. While looking at other people's `vimrc` can certainly be an interesting exercise, one should refrain from looking for solutions to non-existing problems.

Remember, kids... **Pandajail** is where pandas are sent when you use someone else's `vimrc`. Don't be the vimmer responsible for this:

![pandajail](https://i.chzbgr.com/maxW500/7518742016/h59D3B471/)



## TABLE OF CONTENTS

* [Files and directories](#files-and-directories)
* [Miscellaneous advice](#miscellaneous-advice)
* [Defaults.vim](#defaultsvim)
* [Options](#options)
* [Mappings](#mappings)
* [Variables](#variables)
* [Custom commands](#custom-commands)
* [Custom functions](#custom-functions)
* [Autocommands](#autocommands)
* [Conditionals](#conditionals)
* [Colors](#colors)
* [Plugins](#plugins)
* [Suggested minimal settings for programming](#suggested-minimal-settings-for-programming)



## FILES AND DIRECTORIES

Unless you *really* know what you are doing (hint: if you learn anything from this document, it means that you are not there yet), whatever you do to customize Vim should NEVER happen outside of your "home" directory, hereby referred to as `$HOME`:

- on Linux, BSD, and Cygwin, `$HOME` is usually `/home/username/`,
- on Mac OS X, `$HOME` is `/Users/username/`,
- on Windows, `$HOME` is usually `C:\Users\username\`.

If in doubt, open Vim and ask it:

    :echo $HOME

Now that that's out of the way, you must be aware of what Vim calls "runtime files". Vim depends on several of those to work properly, that are located in two "runtime directories": a "system" one and a "user" one. The "system" runtime directory contains all the runtime files that came with Vim and is best left as-is. The "user" runtime directory, located in the aforementioned `$HOME`, is where most of the customization usually happens, by way of editing your own configuration file, called `vimrc`, and moving files around your own runtime directory, called `vimfiles`.

The canonical location for your `vimrc` file and `vimfiles` directory is at the root of the `$HOME` directory mentioned above:

System | `vimrc` | `vimfiles`
---|---|---
UNIX-like | `$HOME/.vimrc` | `$HOME/.vim/`
Windows | `$HOME\_vimrc` | `$HOME\vimfiles\`

Note that Vim doesn't create those files and directories on its own: *you need to create them yourself*.

Since Vim 7.4 it is possible to keep your lovely `vimrc` INSIDE your `vimfiles`. It is really a good idea, if only because it makes it easier to move your config from one machine to another.

The following gives you a neat self-contained setup from 7.4 up:

System | Location
---|---
UNIX-like | `$HOME/.vim/vimrc`
Windows | `$HOME\vimfiles\vimrc`

Here are a few things to keep in mind if you decide to move your `vimrc` into your `vimfiles`, though:

* `.vimrc` loses its dot and `_vimrc` loses its underscore to be come `vimrc`.
* Symbolic links can mess things up in all kinds of ways so make sure your `.vimrc` or `_vimrc` is not already linked and that you actually *move* it rather than copying it.

For the sake of simplicity and agnosticism, `vimrc`, `vimfiles`, and `$HOME` will be used in the rest of the document, regardless of their actual name and path.

### A NOTE ON TUTORIALS

Vim tutorials, including this one, and plugin instructions are often written from a "Unix" perspective, which has been causing confusion among Windows users since forever. If you are on Windows trying to follow Unix-centric instructions, keep in mind the rules below:

- When the author says `~`, `~/`, `$HOME`, or `$HOME/`, read it as `C:\Users\username\`.
- When the author says `vimrc`, `.vimrc`, or `~/.vimrc`, read it as `C:\Users\username\_vimrc` or, if you followed the advice above, `C:\Users\username\vimfiles\vimrc`.
- When the author says `.vim`, `.vim/`, `~/.vim`, `~/.vim/`, read it as `C:\Users\username\vimfiles\`.



## MISCELLANEOUS ADVICE

- Using short names like `fu` or `ai` makes sense when you type them in the command-line but it is useless in your `vimrc`, where it hinders readability while providing nothing in return. Don't.
- Learning how to use Vim's fantastic documentation is the most useful thing a Vim newcomer could do:

      :help :command
      :help function()
      :help 'option'
      :help i_ctrl-a
      :helpgrep foo
      :help get<C-d>
      Press <C-]> (Ctrl+]) on a highlighted tag to jump to the corresponding entry
      Press <C-t> (Ctrl+t) to come back

- Always refer to the relevant `:help` before adding *anything* to your `vimrc`, even from this document.
- You don't need `set nocompatible` if you have a custom `vimrc` at the expected location (see above).
- `set background=dark` doesn't do what you think it does.
- `set t_Co=256` is a bad idea. Vim sets it on its own depending on `$TERM` so set your terminal emulator up properly instead.
- `set paste` has a lot of nasty side effects, don't put it in your `vimrc` before carefully reading `:help 'paste'`.
- If you have many autocommands for many filetype-specific settings, consider moving those settings to proper filetype plugins:

      $HOME/.vim/after/ftplugin/php.vim

- If you have many custom functions, consider moving them to the `autoload/` directory:

      $HOME/.vim/autoload/myfunctions.vim
      call myfunctions#foo()

  See `:help autoload`.

- Vim already gives you the ability to browse local and remote file systems, integrate `ack` or `ag` or `rg`, navigate, complete and compile your code, step through errors, run syntax checkers, read documentation, filter text through external commands, etc. Make sure you have exhausted Vim's features before installing a plugin. Any plugin.



## DEFAULTS.VIM

Vim's spartan defaults having been a contentious topic for a very long time, it has been decided between the releases of Vim 7.4 and Vim 8.0 to provide newcomers with a more user-friendly base setup. The scheme that was devised is to *silently* source a specific runtime file, `defaults.vim` if no `vimrc` is found at the usual locations (see above). And indeed, it works as intended: simply starting Vim without a custom config truly provides a slightly more comfortable experience than previously.

One of the many troubles with that scheme is that embarking on the life-long journey of mastering Vim implies creating one's own `vimrc`, which effectively disables `defaults.vim`. This puts the new user in an even worse position than before: with the spartan defaults everyone likes to hate *and* no idea whatsoever about how to get back the admittedly useful things they got used to because `defaults.vim` is pretty much a black box. Good job!

In case you happen to struggle with that particular problem, two quick and dirty solutions are offered under `:help defaults.vim`. The first is to source that file in your `vimrc`:

    unlet! skip_defaults_vim
    source $VIMRUNTIME/defaults.vim

The second one is to copy its content in your `vimrc`, which you can do like this:

    :0read $VIMRUNTIME/defaults.vim

See `:help :source` and `:help :read`.

NOTE: the author doesn't find any of those solutions particularly satisfying and recommends instead to try to understand what that file does and, *eventually*, to copy the most useful bits over to one's `vimrc`.



## OPTIONS

There are three kinds of options:

- boolean options,
- string options,
- number options.

Checking the value of an option:

- use `:set option?` to check the value of an option,
- use `:verbose set option?` to also see where it was last set.

Getting help for an option:

    :help 'optionname'
    :help 'optionname
    :help optionname'

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

    set numoption&      " Reset numoption to its default value.

- An option can be global (applies to all buffers), window-local (applies to the window where it was set), or buffer-local (applies to the buffer where it was set). Additionally, an option can have both a global value *and* a local one. Using `:help :setlocal` instead of `:set` is a handy way to force a local value but it is not a silver bullet. Read the option's documentation carefully before deciding *how* to set it.
- The `:set` family of commands doesn't accept expressions.

      :set stroption='my string'     " value is literally 'my string', with the quotes
      :set stroption=MyFunction()    " value is literally MyFunction(), not the return value of MyFunction()
      :set numoption=23+4            " throws an error

   Use `:help :let-&` instead:
   
      :let &stroption = 'my string'     " value is my\ string
      :let &stroption = MyFunction()    " value is return value of MyFunction()
      :let &numoption = 23+4            " value is 27


## MAPPINGS

- Don't put comments after mappings, it won't work.
- Use `:map <F6>` to see what is mapped to `<F6>` and in which mode.
- Use `:verbose map <F6>` to also see where it was last mapped.
- See `:help key-notation` for how to express a return or control combo.
- `:map` and `:map!` cover too many modes. Use `:nmap` for normal mode recursive mappings, `:imap` for insert mode, `:xmap` for visual mode, etc.
- See `:help map-commands`.
- Unless they are provided by some packaged-in plugin like Netrw, Vim itself doesn't define *any* mapping. *You* do.

Use non-recursive mappings if you intend to ONLY use default commands in your mappings, which is almost always what you want:

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

The right-hand-side of a mapping is a macro, a series of keystrokes, everything there is typed for you so be careful with spaces and such. For example, the two mappings below don't do the same thing at all:

    nnoremap <key> w i foo <Esc>
    nnoremap <key> wifoo<Esc>



## VARIABLES

Like most scripting languages, vimscript has variables.

One can define a variable with`:help :let`:

    let variable = value

Inspect its value with `:help :echo`:

    echo variable

And delete it with `:help :unlet`:

    unlet variable

Variables can be scoped by prepending a single letter and a colon to their name. Plugin authors use that feature to mimic options:

    let g:plugin_variable = 1

or to keep variables "private":

    let s:script_variable = 'foo'

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
- As mentioned above, keeping one's custom functions under `$HOME/.vim/autoload/` can be a good idea.

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

- See `:help :if`.

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

Do something on Wednesdays:

    if strftime("%u") == 3
      " see :help time-functions
    endif



## COLORS

- GUI Vim (`gvim`, GVim, or the MacVim GUI) can display millions of colors and thus provides the most flexibility.
- TUI Vim (`vim` running in your terminal) is limited by the capabilities of your terminal emulator.
- GUI-specific colorschemes can't be expected to work in TUI Vim.
- TUI-specific colorschemes can't be expected to work in GUI Vim.
- To determine if a pretty colorscheme is right for your environment, look for the following clues:
  - `guibg`/`guifg` means GUI support and, probably, "true colors" support as well,
  - `ctermbg`/`ctermfg` means TUI support,
  - `if &t_Co >= 256` is a test to see if your terminal emulator supports 256 colors, which probably means that the scenario is supported to some extent,
  - `if &t_Co >= 16` is a test to see if your terminal emulator supports 16 colors, which probably means that the scenario is supported to some extent.
- Feature detection is not exactly a solved problem in Vim, so it is best not to assume anything.

The standard location for a standalone colorscheme is:

    $HOME/.vim/colors/foobar.vim

You can make it the current one with:

    :colorscheme foobar

And persist that choice by adding this line to your `vimrc`:

    colorscheme foobar

NOTE: most colorschemes these days are provided as "plugins". Read on to see how these work.



## PLUGINS

Vim does a lot but we can count on its thriving plugin ecosystem for when the built-in features are not enough. Look for plugins that:

- follow Vim's philosophy,
- don't duplicate built-in features,
- let you (re)define their mappings,
- don't have crazy requirements.

Vim plugins are to be installed in your `vimfiles` directory and **NOWHERE** else.

Properly designed plugins usually follow Vim's own runtime directory's structure:

- filetype-specific scripts are named after their filetype and go into `ftplugin/`

      $HOME/.vim/ftplugin/javascript.vim

- filetype-specific indent scripts are named after their filetype and go into `indent/`

      $HOME/.vim/indent/javascript.vim

- filetype-specific syntax scripts are named after their filetype and go into `syntax/`

      $HOME/.vim/syntax/javascript.vim

- autoloaded scripts go into `autoload/`

      $HOME/.vim/autoload/foo.vim

- plugin scripts go into `plugin/`

      $HOME/.vim/plugin/foo.vim

- plugin documentation goes into `doc/`

      $HOME/.vim/doc/foo.txt

- etc.

Historically, the normal method for installing plugins was to put each file in its corresponding directory under one's `vimfiles`, as above. It was messy and the more plugins you added the messier your `vimfiles` would get.

To solve that problem, a number of what people call "plugin managers" appeared, all more or less built around the same logic: each plugin is kept in its own directory under a common parent directory and Vim is told where to find those plugins via `:help 'runtimepath'`.

Note that using a plugin manager is not an absolute requirement. After all, the traditional way was messy but workable, but if you think you need one, make sure you read and understand its `README.md` before using it.

### Vim 8's "package" feature

Vim 8 introduced a new scheme called *package* that lets you organise your plugins in so-called "packages" and decide whether they are to be enabled at startup or manually:

Directory | Description
---|---
`pack/{arbitrary name}/start/` | Plugins in this directory are enabled automatically at startup
`pack/{arbitrary name}/opt/` | Plugins in this directory are enabled manually

For example, here is the author's setup:

* `$HOME/.vim/pack/bundle/start/` is where he puts all his "quality of life" plugins,
* `$HOME/.vim/pack/lang/start/` is where he puts all his "language support" plugins.

While that feature is a clear improvement, it is still *not* an actual plugin manager and you *may* still have to use one if you need one.

See `:help package`.



## SUGGESTED MINIMAL SETTINGS FOR PROGRAMMING

How you customise your tools is entirely dependant on a) what you use them for and b) how well you know them, so YMMV. In that spirit, the settings below are only suggestions, based on what the author would do if he had to work on a new machine for a couple of hours and didn't feel like installing his full config.

    " Enabling filetype support provides filetype-specific indenting,
    " syntax highlighting, omni-completion and other useful settings.
    filetype plugin indent on
    syntax on

    " `matchit.vim` is built-in so let's enable it!
    " Hit `%` on `if` to jump to `else`.
    runtime macros/matchit.vim

    " various settings
    set autoindent                 " Minimal automatic indenting for any filetype.
    set backspace=indent,eol,start " Intuitive backspace behavior.
    set hidden                     " Possibility to have more than one unsaved buffers.
    set incsearch                  " Incremental search, hit `<CR>` to stop.
    set ruler                      " Shows the current line number at the bottom-right
                                   " of the screen.
    set wildmenu                   " Great command-line completion, use `<Tab>` to move
                                   " around and `<CR>` to validate.



[//]: # ( Vim: set spell spelllang=en: )
